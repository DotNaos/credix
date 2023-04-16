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

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Create a Dashboard in a modern UI and UX design and show the user data
  // The user data is stored in the UserData class

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DataItem(
          title: 'Points',
          value: UserData.generateRandomData(),
        ),

        // Points Gained in total
        DataItem(
          title: 'Points Gained',
          value: UserData.pointsGained,
          textStyle: const TextStyle(
            color: Colors.green,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        DataItem(title: 'Goodbehaviors', value: UserData.goodBehaviors),

        // Points Lost in total
        DataItem(
          title: 'Points Lost',
          value: UserData.pointsLost,
          textStyle: const TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        DataItem(title: 'Violations', value: UserData.violations),
      ],
    );
  }
}
