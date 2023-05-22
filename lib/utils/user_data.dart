// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> addUserData(String name, int age, String email) async {
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
}
