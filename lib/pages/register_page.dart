import 'package:flutter/material.dart';
import 'package:flutterproject/components/my_button.dart';
import 'package:flutterproject/components/my_textfield.dart';
import 'package:flutterproject/components/square_tile.dart';
import 'package:flutterproject/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user in method
  void signUserUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (mounted) {
          Navigator.pop(context); // Close loading dialog only after successful registration
        }
      } else {
        if (mounted) {
          Navigator.pop(context); // Close loading dialog before showing error
          _showErrorDialog("Passwords don't match!");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading dialog before showing error
        
        String errorMessage = "An error occurred";
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = "This email is already registered. Please try logging in.";
            break;
          case 'invalid-email':
            errorMessage = "Please enter a valid email address.";
            break;
          case 'weak-password':
            errorMessage = "The password provided is too weak.";
            break;
          default:
            errorMessage = e.message ?? "An error occurred during registration.";
        }
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading dialog before showing error
        _showErrorDialog("An unexpected error occurred. Please try again.");
      }
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void signInWithGoogle() async {
    showDialog(
     context: context,
     barrierDismissible: false,
     builder: (context) {
       return const Center(
         child: CircularProgressIndicator(),
       );
      },
    );

    try {
      AuthService authService = AuthService();
      User? user = await authService.signInWithGoogle();

      Navigator.pop(context); // Close the loading dialog

      if (user != null) {
        // User successfully signed in
        // You can navigate to the next page or show a success message
        print("Google Sign-In successful: ${user.email}");
      } else {
        // User canceled the sign-in
        _showErrorDialog("Google Sign-In canceled!");
      }
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      _showErrorDialog("Google Sign-In failed!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // logo
                const Icon(
                  Icons.lock,
                  size: 80,
                ),

                const SizedBox(height: 25),

                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),

                const SizedBox(height: 25),

                // or continue with
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // google sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: signInWithGoogle,
                      child: const SquareTile(imagePath: 'lib/images/google.png'),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Add bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
