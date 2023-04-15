// ignore_for_file: slash_for_doc_comments

/**
 * On this page the user can see the list of bonuses
 * the user will get the bonus if he/she has enough points
 * the user can see the bonus details by clicking on the bonus
 */

import 'package:flutter/material.dart';

class BonusListPage extends StatefulWidget {
  const BonusListPage({super.key});

  @override
  _BonusListPageState createState() => _BonusListPageState();
}

class _BonusListPageState extends State<BonusListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Bonus List'),
      ],
    );
  }
}
