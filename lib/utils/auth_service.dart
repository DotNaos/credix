import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  // Sign in with email and password
  void signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // final GoogleSignInAuthentication googleAuth =
    //     await googleUser!.authentication;

    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );

    // return await FirebaseAuth.instance.signInWithCredential(credential);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // continue with sign-in process
    } catch (e) {
      if (e is PlatformException && e.code == 'sign_in_canceled') {
        // handle cancellation error
      } else {}
    }
  }

  // Store user data in Firestore
  Future<void> storeUserData(String uid, String name, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  // Read user data from Firestore
  Future<Map<String, dynamic>> getUserData(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.data() as Map<String, dynamic>;
  }
}
