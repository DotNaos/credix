// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

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
    addUser();
    final snapshot = await firestore.collection('users').doc(user!.uid).get();
    return snapshot.data()!;
  }

  void changeProfilePicture(String path) {
    user!.updatePhotoURL(path);
  }

  Future<void> addUser() async {
    List<String> entries = getEntries();
    Map<String, dynamic> userData = {
      'name': user!.displayName ?? user!.email!.split('@')[0],
      'email': user!.email!,
      'tasksMonth': 10,
      for (String entry in entries) entry: entry == 'points' ? 1000 : 0,
    };
    DocumentSnapshot doc =
        await firestore.collection('users').doc(user!.uid).get();

    if (doc.exists) {
      return Future.value();
    }

    return await firestore.collection('users').doc(user!.uid).set(userData);
  }

  List<String> getEntries() {
    return ['points', 'violations', 'completed tasks'];
  }

  void addPoints(int i) {
    firestore.collection('users').doc(user!.uid).update({
      'points': FieldValue.increment(i),
    });
  }

  void addOnto(String field) {
    firestore.collection('users').doc(user!.uid).update({
      field: FieldValue.increment(1),
    });
  }

  void subtractFrom(String field) {
    firestore.collection('users').doc(user!.uid).update({
      field: FieldValue.increment(-1),
    });
  }

  // Return the value of a field from the database
  valueFromDatabase(String field) async {
    addUser();
    DocumentSnapshot doc =
        await firestore.collection('users').doc(user!.uid).get();
    return doc[field];
  }

  getStream() {
    addUser();
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  void addReport(
    String user,
    int pointsCost,
    String? description,
    File? image,
  ) {
    description == '' || description == null
        ? description = 'No description provided'
        : description;

    // Add a new violation with Points Cost and Description and Date
    // Add it to a new collection called 'violations' in the users document

    // Get the current date until the minute
    String date = DateTime.now().toString().substring(0, 16);

    // Also add the location of the violation
    // Get the current location of the user

    var location = getCurrentLocation();

    // Add the location to the database
    firestore.collection('users').doc(user).collection('violations').add({
      'pointsCost': pointsCost,
      'description': description,
      'date': date,
      'location': location
    });

    // Add the points cost to the user's points
    firestore.collection('users').doc(user).update({
      'points': FieldValue.increment(-pointsCost),
    });

    // If the users points are less than 0, set them to 0
    firestore.collection('users').doc(user).get().then((doc) {
      if (doc['points'] < 0) {
        firestore.collection('users').doc(user).update({'points': 0});
      }
    });

    // increment the number of violations
    firestore.collection('users').doc(user).update({
      'violations': FieldValue.increment(1),
    });
  }

  getCurrentLocation() {
    // Get the current location of the user
    Location location = Location();
    location.getLocation().then((locationData) {
      return locationData;
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
