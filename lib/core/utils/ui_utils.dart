import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UiUtils {
  static void showSnackBar(BuildContext context, {
     required String message,
     bool isError = false, 
     Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),

      ),
      backgroundColor: isError? Colors.red : Colors.blueAccent,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
      )
    );
  }
}