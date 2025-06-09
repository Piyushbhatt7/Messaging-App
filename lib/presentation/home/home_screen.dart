import 'package:chatt_app/data/services/service_locator.dart';
import 'package:chatt_app/logic/cubits/auth/auth_cubit.dart';
import 'package:chatt_app/presentation/screens/auth/login_screen.dart';
import 'package:chatt_app/router/app_router.dart';
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
      title: Text("Chats"),
      actions: [
        InkWell(
          onTap: () async{
           await getIt<AuthCubit>().signOut();
           getIt<AppRouter>().pushAndRemoveUntil(const LoginScreen());
          },
          child: Icon(Icons.logout))
      ],
    ),
      body: Center(
        child: Text("Home screen"),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {

      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.chat_rounded, color: Colors.white,),
      ),
    );
  }
}