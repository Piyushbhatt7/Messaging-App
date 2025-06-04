import 'package:flutter/material.dart';

class AppTheme {

  static const primaryColor = Color(0XFFFFA8DADC);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme:  ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0xffF7CFD8),
      surface: Colors.white,
      onSurface: Colors.black,
      tertiary: Color(0xFF7CBEC2),
      onPrimary: Colors.black87,
    ),

    appBarTheme: const AppBarTheme(
      
    )
  )
}