import 'package:chatt_app/config/theme/app_theme.dart';
import 'package:chatt_app/firebase_options.dart';
import 'package:chatt_app/presentation/screens/auth/login_screen.dart';
import 'package:chatt_app/presentation/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger App',
      theme: AppTheme.lightTheme,
      home: SignupScreen(),
    );
  }
}
