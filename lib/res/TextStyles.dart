import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle header({Color? color, double? fontSize}) => TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle details({Color? color, double? fontSize}) => TextStyle(
        color: color ?? Colors.grey.shade200,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );
}
