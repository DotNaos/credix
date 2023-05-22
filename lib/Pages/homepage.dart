import 'package:credix/Pages/settings.dart';
import 'package:credix/Pages/tasklist.dart';
import 'package:credix/Pages/verify.dart';
import 'package:credix/Pages/violations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Components/account_screen.dart';
import 'bonus_list.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    BonusListPage(),
    ViolationListPage(),
    TaskListPage(),
    VerifyPage(),
    SettingsPage(),
  ];

  static const List<String> _pageTitles = <String>[
    'Dashboard',
    'Bonuses',
    'Violations',
    'Tasks',
    'Verify',
    'Settings',
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
        actions: [
          IconButton(
            // if the user is logged in, show the profile icon
            icon: FirebaseAuth.instance.currentUser != null
                ?
                // if the user has a profile picture, show it
                FirebaseAuth.instance.currentUser!.photoURL != null
                    ? CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!),
                        backgroundColor: Colors.white,
                      )
                    : const Icon(Icons.account_circle)
                : const Icon(Icons.login),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
        ],
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
            icon: Icon(Icons.warning),
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
        onTap: _onItemTapped,
      ),
    );
  }
}
