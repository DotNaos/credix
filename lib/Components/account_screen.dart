import 'package:credix/Components/animated_gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/user_data.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AccountAvatar(),
            const SizedBox(height: 16),
            if (_auth.currentUser!.displayName != null)
              Text(
                _auth.currentUser!.displayName!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            const SizedBox(height: 8),
            Text(
              _auth.currentUser!.email!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            AnimatedGradientButton(
                buttonText: 'Sign out',
                onPressed: () async {
                  // Sign out regardless of provider
                  await _googleSignIn.signOut();
                  await _auth.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                gradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Color.fromARGB(255, 59, 255, 147),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
