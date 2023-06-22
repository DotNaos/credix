import 'package:credix/utils/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Components/animated_gradient_button.dart';
import '../Components/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 50),
                    // Log in text
                    const Text(
                      'Log In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Email input field
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password input field
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Sign in button
                    AnimatedGradientButton(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 52, 90, 214),
                          Color.fromARGB(255, 121, 157, 255),
                          Color.fromARGB(255, 102, 255, 171)
                        ],
                      ),
                      buttonText: 'Sign in',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Show what this returns
                          AuthService()
                              .signInWithEmailAndPassword(_email, _password);
                        } else {
                          // Show a popup
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Please enter a valid email and password.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    !kIsWeb
                        ? Column(
                            children: [
                              // Add a horizontal divider
                              const Divider(
                                height: 40,
                                thickness: 0.5,
                                color: Color.fromARGB(255, 75, 75, 75),
                              ),
                              // Google sign in button
                              ElevatedButton.icon(
                                onPressed: () async {
                                  AuthService().signInWithGoogle();
                                },
                                icon: Image.asset('assets/google_logo.png',
                                    height: 24),
                                label: const Text('Sign in with Google',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    )),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      const Color.fromARGB(221, 73, 44, 44),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(height: 0),

                    // Sign up button

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Show the sign up page as a modal
                            // If the user is logged in then close the modal

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => const SignUpPage(),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
