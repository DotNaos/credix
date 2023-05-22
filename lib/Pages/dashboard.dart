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

import 'package:flutter/material.dart';

// User Data
import 'package:credix/utils/user_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Create a Dashboard in a modern UI and UX design and show the user data
  // The user data is stored in the UserData class

  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Column(
      // Show the points from the user data on firebase
      children: [
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            SvgPicture.asset('assets/Card.svg',
                width: 300,
                // Set the HSV values for the background color
                colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 162, 0, 255), BlendMode.modulate)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Points",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    "100",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
