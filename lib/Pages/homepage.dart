import 'package:credix/Pages/settings.dart';
import 'package:credix/Pages/tasklist.dart';
import 'package:credix/Pages/verify.dart';
import 'package:credix/Pages/violations.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Components/account_screen.dart';
import 'bonus_list.dart';
import 'dashboard.dart';
import 'login.dart';

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
    final GoogleSignInAccount? user = GoogleSignIn().currentUser;
    final bool isSignedIn = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles.elementAt(_selectedIndex)),
        actions: [
          if (isSignedIn)
            IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl ?? ''),
              ),
              onPressed: () {},
            )
          else
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // TODO: Implement account screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountScreen()),
                );
              },
            ),
        ],
      ),
      body: Center(
        child: isSignedIn
            ? _widgetOptions.elementAt(_selectedIndex)
            : const LoginPage(),
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
        backgroundColor: Colors.blueGrey[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
