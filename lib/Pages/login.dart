import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Components/animated_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  var _isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Padding(
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
                        buttonText: 'Submit',
                        onPressed: () {
                          setState(() {
                            // _isLoading = true;
                          });

                          if (_formKey.currentState!.validate()) {
                            // Show what this returns

                            Future<UserCredential> userCredential = FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: _email, password: _password);
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
                          setState(() {
                            _isLoading = false;
                          });
                        },
                      ),
                      // Add a horizontal divider
                      const Divider(
                        height: 40,
                        thickness: 0.5,
                        color: Color.fromARGB(255, 75, 75, 75),
                      ),
                      // Google sign in button
                      ElevatedButton.icon(
                        onPressed: () async {
                          _googleSignIn.signIn().then(
                            (userData) {
                              String name = userData!.displayName!;
                              String email = userData.email;
                              String imageUrl = userData.photoUrl!;
                            },
                          );
                        },
                        icon: Image.asset('assets/google_logo.png', height: 24),
                        label: const Text('Sign in with Google'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
