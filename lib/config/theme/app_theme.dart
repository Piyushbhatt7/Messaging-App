import 'package:flutter/material.dart';

class AppTheme {

  static const primaryColor = Color(0xff5F99AE);

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

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primaryColor.withOpacity(0.1),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),  
        borderSide: BorderSide.none,   
      ),  
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24), 
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: primaryColor),
      ),

      hintStyle: TextStyle(
        color: Colors.grey[600],
        
      )
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      )
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18.0, // 36.52
      )
    )
  );
}