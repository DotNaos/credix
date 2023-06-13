// ignore_for_file: slash_for_doc_comments, unused_import

/**
 * The page is displayed in the body of the app and does not use a scaffold
 * On this page the user can see various statistics about his/her behavior
 * this includes the number of violations, the number of good behaviors,
 * the number of points gained, the number of points lost, the number of bonuses
 * and overall the number of points
 * 
 * The app has a modern UI and UX design
 */

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// User Data
import 'package:credix/utils/user_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Create a Dashboard in a modern UI and UX design and show the user data
  // The user data is stored in the UserData class

  UserData userData = UserData();

  // List of things to show
  List<String> thingsToShow = [
    'violations',
    'good behaviors',
    'points gained',
    'points lost',
    'bonuses'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      // Show the points from the user data on firebase
      children: [
        const Expanded(
          flex: 2,
          child: Row(
            // User Profile Picture
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AccountAvatar(),
              Text(
                '1000',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).hoverColor,
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  height: 30,
                ),
                // Show the statistics from the user data on firebase
                Expanded(
                  child: ListView.builder(
                    itemCount: thingsToShow.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(thingsToShow[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  // Show the text in caps lock
                                  textBaseline: TextBaseline.alphabetic,
                                  fontFeatures: [
                                    FontFeature.enable('smcp'),
                                  ],
                                )),
                            const Text('1000', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Show a Button to update the user data
                ElevatedButton(
                  onPressed: () async {
                    // Get the user data from firebase from the current user

                    FirebaseFirestore db = FirebaseFirestore.instance;

                    // Get the users points from the database
                    DocumentSnapshot<Map<String, dynamic>> snapshot =
                        await db.collection('user').doc('points').get();

                    // Update the user data
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
