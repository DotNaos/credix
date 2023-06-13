// ignore_for_file: slash_for_doc_comments

/**
 * On this page the user can see the list of bonuses
 * the user will get the bonus if he/she has enough points
 * the user can see the bonus details by clicking on the bonus
 */

import 'dart:math';

import 'package:flutter/material.dart';

class BonusListPage extends StatefulWidget {
  const BonusListPage({super.key});

  @override
  _BonusListPageState createState() => _BonusListPageState();
}

class _BonusListPageState extends State<BonusListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (int i = 0; i < 100; i++)
        const BonusListTile(
          key: Key('BonusListTile'),
        ),
    ]);
  }
}

class BonusListTile extends StatefulWidget {
  const BonusListTile({super.key});

  @override
  State<BonusListTile> createState() => _BonusListTileState();
}

class _BonusListTileState extends State<BonusListTile> {
  // List of all possible bonuses
  static final List<String> _boniTitles = <String>[
    'Tax Free Food',
    'Tax Free Clothes',
    'Tax Free Electronics',
    'Tax Free Furniture',
    'Tax Free Books',
    'Ticket for the next football game',
    'Ticket for the next basketball game',
    'Ticket for the next baseball game',
    'Ticket for flight to singapore',
    'Ticket for flight to new york',
  ];

  // List of all possible bonus descriptions
  static final List<String> _boniDescriptions = <String>[
    'You can buy food without paying taxes',
    'You can buy clothes without paying taxes',
    'You can buy electronics without paying taxes',
    'You can buy furniture without paying taxes',
    'You can buy books without paying taxes',
    'You can watch the next football game for free',
    'You can watch the next basketball game for free',
    'You can watch the next baseball game for free',
    'You can fly to singapore for free',
    'You can fly to new york for free',
  ];

  // List of all possible bonus icons
  static final List<IconData> _boniIcons = <IconData>[
    Icons.food_bank,
    Icons.shopping_bag,
    Icons.electrical_services,
    Icons.chair,
    Icons.book,
    Icons.sports_football,
    Icons.sports_basketball,
    Icons.sports_baseball,
    Icons.airplanemode_active,
    Icons.airplanemode_active,
  ];

  @override
  Widget build(BuildContext context) {
    int index = Random().nextInt(_boniTitles.length);
    return ListTile(
      leading: Icon(_boniIcons[index]),
      title: Text(_boniTitles[index]),
      subtitle: Text('expires in ${Random().nextInt(30)} days'),
      trailing: Text(
          'needed points: ${1000 - (Random().nextInt(10) * 10) + (Random().nextInt(10) * 20)}'),
    );
  }
}
