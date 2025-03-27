import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/components/my_button.dart';
import 'package:flutterproject/components/square_tile.dart';
import 'package:flutterproject/pages/quiz_page.dart';
import 'package:flutterproject/pages/quiz_history_page.dart';

class HomePage extends StatelessWidget {
    HomePage({super.key});

    final user = FirebaseAuth.instance.currentUser!;

    // sign user out method
    void signUserOut() {
        FirebaseAuth.instance.signOut();
    }

    @override
    Widget build (BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                    "Home",
                    style: TextStyle(color: Colors.grey[700]),
                ),
                actions: [
                    IconButton(
                        onPressed: signUserOut, 
                        icon: const Icon(Icons.logout),
                        color: Colors.grey[700],
                    )
                ]
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
                                Icons.home,
                                size: 80,
                                color: Colors.deepPurple,
                            ),

                            const SizedBox(height: 25),

                            // welcome message
                            Text(
                                'Welcome to Apptitude App',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 25),

                            // Profile Section Button
                            MyButton(
                                text: "View Profile",
                                onTap: () {
                                    // Add profile view functionality
                                },
                            ),

                            const SizedBox(height: 25),

                            // Settings Section Button
                            MyButton(
                                text: "Start Test",
                                onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const QuestionCountSelection(),
                                        ),
                                    );
                                },
                            ),

                            const SizedBox(height: 10),

                            // View History button
                            MyButton(
                                text: "View Quiz History",
                                onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const QuizHistoryPage(),
                                        ),
                                    );
                                },
                            ),

                            const SizedBox(height: 25),
                        ],
                    ),
                ),
            ),
        );  
    }
}