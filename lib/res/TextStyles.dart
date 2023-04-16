import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle header({Color? color, double? fontSize}) => TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.bold,
      );
}
