// ignore_for_file: slash_for_doc_comments

/**
 * 
 * On this page the user can sign in or sign up
 * sign in methods include: email and password, google
 * google sign in uses firebase
 * 
 */

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  String _email;
  String _password;
  bool _loading = false;

  Future<UserCredential> _signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        print('Signed in: ${userCredential.user.email}');
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in. Please try again.')),
        );
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _signInWithEmailAndPassword,
                      child: Text('Sign In'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final userCredential = await _signInWithGoogle();
                          print(
                              'Signed in with Google: ${userCredential.user.email}');
                        } catch (e) {
                          print('Error: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Failed to sign in with Google. Please try again.')),
                          );
                        }
                      },
                      child: Text('Sign in with Google'),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up page
                      },
                      child: Text('Don\'t have an account? Sign up.'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
