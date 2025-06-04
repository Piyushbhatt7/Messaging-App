import 'package:flutter/material.dart';

class AppTheme {

  static const primaryColor = Color(0XFFFFA8DADC)

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme:  ColorScheme.light(
      primary: primaryColor
    )
  )
}