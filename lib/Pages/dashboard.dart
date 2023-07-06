// ignore_for_file: slash_for_doc_comments, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<String> thingsToShow = UserData().getEntries();

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
              ValueFromDatabase(value: "points"),
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
                  child: ListFromDatabase(values: thingsToShow),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Widget that shows a value from the database and listens for changes
// The value is passed as a parameter

class ValueFromDatabase extends StatelessWidget {
  const ValueFromDatabase({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserData().getStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data[value].toString(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

// Widget that is a scrollable list of all the data from the database
// A list of values is passed as a parameter

class ListFromDatabase extends StatelessWidget {
  const ListFromDatabase({Key? key, required this.values}) : super(key: key);

  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserData().getStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      values[index],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      snapshot.data[values[index]].toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
