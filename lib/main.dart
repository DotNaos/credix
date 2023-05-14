// ignore_for_file: unused_import

// Reference: https://ub.triviumchina.com/2019/10/long-read-the-apps-of-chinas-social-credit-system/

import 'package:flutter/material.dart';
import 'package:credix/Pages/homepage.dart';
import 'package:credix/res/custom_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
