import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      actions: [
        InkWell(
          onTap: () {
            
          },
          child: Icon(Icons.logout))
      ],
    ),
      body: Center(
        child: Text("Home screen"),
      ),
    );
  }
}