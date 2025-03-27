import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterproject/components/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionCountSelection extends StatefulWidget {
  const QuestionCountSelection({super.key});

  @override
  State<QuestionCountSelection> createState() => _QuestionCountSelectionState();
}

class _QuestionCountSelectionState extends State<QuestionCountSelection> {
  final List<int> availableQuestions = [5, 10, 20, 30, 40, 50];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Select Number of Questions",
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),

              // logo
              const Icon(
                Icons.quiz,
                size: 80,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 25),

              // welcome message
              Text(
                'Choose your quiz length',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              // Question count buttons
              ...availableQuestions.map((count) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MyButton(
                    text: "Answer $count Questions",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuizScreen(questionLimit: count),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final int questionLimit;

  const QuizScreen({super.key, required this.questionLimit});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<Map<String, dynamic>> randomData;
  String selectedOption = '';
  bool isAnswerCorrect = false;
  String explanation = '';
  String correctAnswer = '';
  bool showExplanation = false;
  bool isOptionSelected = false;
  int correctAnswers = 0;
  int questionCount = 1;
  int remainingTime = 75;
  Timer? countdownTimer;
  bool isTimerRunning = false;

  Future<Map<String, dynamic>> fetchRandomData() async {
    final response =
        await http.get(Uri.parse('https://aptitude-api.vercel.app/Random'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    randomData = fetchRandomData();
  }

  void checkAnswer(
      String option, String correctOption, String explanationText) {
    setState(() {
      selectedOption = option;
      isOptionSelected = true;
      if (option == correctOption) {
        isAnswerCorrect = true;
        correctAnswers++;
      } else {
        isAnswerCorrect = false;
        correctAnswer = correctOption;
      }
      explanation = explanationText;
      showExplanation = true;
    });
    stopTimer();
  }

  void loadNextQuestion() {
    if (questionCount < widget.questionLimit) {
      setState(() {
        questionCount++;
        showExplanation = false;
        isOptionSelected = false;
        selectedOption = '';
        randomData = fetchRandomData();
        remainingTime = 75;
        startTimer();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            correctAnswers: correctAnswers,
            totalQuestions: widget.questionLimit,
          ),
        ),
      );
    }
  }

  void startTimer() {
    stopTimer();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        stopTimer();
        if (!isOptionSelected) {
          setState(() {
            isAnswerCorrect = false;
            correctAnswer = 'No answer';
            explanation = 'You ran out of time!';
            showExplanation = true;
            isOptionSelected = true;
          });
        }
        loadNextQuestion();
      }
    });
  }

  void stopTimer() {
    countdownTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Quiz Questions",
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<Map<String, dynamic>>(
          future: randomData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              final question = data['question'] ?? 'No question available';
              final options = List<String>.from(data['options'] ?? []);
              final correctOption = data['answer'] ?? '';
              final explanationText =
                  data['explanation'] ?? 'No explanation available';

              if (questionCount == 1 && !isTimerRunning) {
                startTimer();
                isTimerRunning = true;
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Question counter
                      Text(
                        'Question $questionCount/${widget.questionLimit}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Timer
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.timer, color: Colors.deepPurple),
                            const SizedBox(width: 5),
                            Text(
                              '$remainingTime seconds',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Question
                      Text(
                        question,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Options
                      ...options.map((option) {
                        Color buttonColor = Colors.deepPurple;
                        if (isOptionSelected) {
                          if (option == correctOption) {
                            buttonColor = Colors.green;
                          } else if (option == selectedOption) {
                            buttonColor = Colors.red;
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ElevatedButton(
                            onPressed: isOptionSelected
                                ? null
                                : () {
                                    checkAnswer(option, correctOption, explanationText);
                                  },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(buttonColor),
                              minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                      if (showExplanation)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                isAnswerCorrect
                                    ? 'Correct Answer!'
                                    : 'Incorrect Answer',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isAnswerCorrect
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Explanation: $explanation',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (isOptionSelected)
                        MyButton(
                          text: "Next Question",
                          onTap: loadNextQuestion,
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

class ScoreScreen extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  Future<void> saveScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();
      final date = '${now.day}/${now.month}/${now.year}';
      
      final scoreData = {
        'date': date,
        'correctAnswers': widget.correctAnswers,
        'totalQuestions': widget.totalQuestions,
        'percentage': (widget.correctAnswers / widget.totalQuestions * 100).toStringAsFixed(1),
      };

      final historyJson = prefs.getStringList('quiz_history') ?? [];
      historyJson.add(jsonEncode(scoreData));
      await prefs.setStringList('quiz_history', historyJson);

      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Score saved successfully!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to save score: $e'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double scorePercentage =
        (widget.correctAnswers / widget.totalQuestions) * 100;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Quiz Results",
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),

              // Score icon
              const Icon(
                Icons.emoji_events,
                size: 80,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 25),

              // Score title
              Text(
                'Your Score',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 20),

              // Score display
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: widget.correctAnswers),
                      duration: const Duration(seconds: 2),
                      builder: (context, value, child) {
                        return Text(
                          '$value',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        );
                      },
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: widget.totalQuestions),
                      duration: const Duration(seconds: 2),
                      builder: (context, value, child) {
                        return Text(
                          '$value',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Percentage
              Text(
                '${scorePercentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 30),

              // Save Score button
              MyButton(
                text: "Save Score",
                onTap: saveScore,
              ),

              const SizedBox(height: 10),

              // Retry button
              MyButton(
                text: "Try Again",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuestionCountSelection()),
                  );
                },
              ),

              const SizedBox(height: 10),

              // Exit button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
