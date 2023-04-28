import 'package:flutter/material.dart';

import 'package:credix/Pages/dashboard.dart';
import 'package:credix/Pages/bonus_list.dart';
import 'package:credix/Pages/violations.dart';
import 'package:credix/Pages/tasklist.dart';
import 'package:credix/Pages/verify.dart';
import 'package:credix/Pages/settings.dart';

import 'package:credix/res/custom_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of pages and their titles
  static const List<String> _pageTitles = <String>[
    'Dashboard',
    'Bonuses',
    'Violations',
    'Tasks',
    'Verify',
    'Settings',
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    BonusListPage(),
    ViolationListPage(),
    TaskListPage(),
    VerifyPage(),
    SettingsPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles.elementAt(_selectedIndex)),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Bonuses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.error),
            label: 'Violations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'Verify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomColors.secondary,
        onTap: _onItemTapped,
      ),
    );
  }
}
