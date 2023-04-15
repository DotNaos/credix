// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:credix/Pages/homepage.dart';
import 'package:credix/res/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'credix',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: CustomColors.primary,
      //     onPrimary: CustomColors.onPrimary,
      //     secondary: CustomColors.secondary,
      //     onSecondary: CustomColors.onSecondary,
      //     error: CustomColors.error,
      //     onError: CustomColors.onError,
      //     background: CustomColors.background,
      //     onBackground: CustomColors.onBackground,
      //     surface: CustomColors.surface,
      //     onSurface: CustomColors.onSurface,
      //   ),
      // ),
      theme: ThemeData.dark().copyWith(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
