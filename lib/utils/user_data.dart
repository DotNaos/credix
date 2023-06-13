// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> addUserData(String name, int age, String email) async {
    // If the document doesn't exist, it will be created.
    await firestore.collection('users').doc(user!.uid).set({
      'name': name,
      'age': age,
      'email': email,
    });
  }

  Future<Map<String, dynamic>> getUserData() async {
    final snapshot = await firestore.collection('users').doc(user!.uid).get();
    return snapshot.data()!;
  }

  void changeProfilePicture(String path) {
    user!.updatePhotoURL(path);
  }

  void addUser() {
    firestore.collection('users').doc(user!.uid).set({
      'name': user!.displayName,
      'email': user!.email,
      'age': 0,
      'points': 0,
    });
  }
}

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: FirebaseAuth.instance.currentUser!.photoURL != null
          ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
          : null,
      radius: 50,
      child: FirebaseAuth.instance.currentUser!.photoURL == null
          ? const Icon(Icons.person, size: 50)
          : null,
    );
  }
}
