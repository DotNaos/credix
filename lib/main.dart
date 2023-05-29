// ignore_for_file: unused_import

// Reference: https://ub.triviumchina.com/2019/10/long-read-the-apps-of-chinas-social-credit-system/

import 'package:credix/Pages/login.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:credix/Pages/homepage.dart';
import 'package:credix/res/custom_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCyKuJQ9eK2OlCv60aPoYlXD0lX-GcyKfk",
          appId: "1:198559573731:web:f037ee595aa9868c0d07d6",
          messagingSenderId: "198559573731",
          projectId: "credix-be37c"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;
  ThemeMode themeMode = ThemeMode.system;
  final Color _colorSchemeSeed = Colors.teal;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          title: 'Credix',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            colorSchemeSeed: _colorSchemeSeed,
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: _colorSchemeSeed,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          home: _user != null ? const HomePage() : const LoginPage());
    });
  }
}
