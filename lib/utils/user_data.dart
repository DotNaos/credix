import 'package:flutter/material.dart';

class UserData {
  // random 16bit id
  static int id = 0x7fff & (DateTime.now().millisecondsSinceEpoch >> 16);

  static String name = 'John Doe';

  // Random value between 600 and 1300
  static int points = 600 + (DateTime.now().millisecondsSinceEpoch % 700);

  static int pointsLost = 0;
  static int pointsGained = 0;

  static int violations = 0;
  static int goodBehaviors = 0;

  static int generateRandomData() {
    id = 0x7fff & (DateTime.now().millisecondsSinceEpoch >> 16);
    name = 'John Doe';

    // 80 % of people are good persons
    if (DateTime.now().millisecondsSinceEpoch % 10 < 8) {
      // Generate a random number between 1100 and 1500
      points = 1100 + (DateTime.now().millisecondsSinceEpoch % 400);
      pointsGained = points - 1000;

      // A person gets between 20 and 60 points for a good behavior
      goodBehaviors = pointsGained ~/ 20;

      // No person is perfect so every person has around 1 or 2 violations
      violations = 1 + (DateTime.now().millisecondsSinceEpoch % 2);
      pointsLost = violations * 40;

      points -= pointsLost;
    } else {
      // Generate a random number between 700 and 900
      points = 700 + (DateTime.now().millisecondsSinceEpoch % 200);
      pointsLost = 1000 - points;

      // A person loses between 40 and 100 points for a violation
      violations = pointsLost ~/ 40;

      // Every person has at least 1 good behavior
      goodBehaviors = 1 + (DateTime.now().millisecondsSinceEpoch % 2);
      pointsGained = goodBehaviors * 20;

      points += pointsGained;
    }

    return points;
  }
}

class DataItem extends StatelessWidget {
  const DataItem(
      {super.key, required this.title, required this.value, this.textStyle});

  final String title;
  final int value;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title: ',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toString(),
          style: textStyle ??
              const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
