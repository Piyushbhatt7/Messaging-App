import 'package:chatt_app/core/common/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 30.0,),
              Text("Welcome Back", 
              style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
              
              ),

              const SizedBox(height: 10.0,),

               Text(
                "Sign in to continue", 
              style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.grey
              )    
              ),
                   // email
              CustomTextField(
                controller: emailController, 
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
                ),
                   // password
                 CustomTextField(
                controller: passwordController, 
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
                obscureText: true,
                ),
            ],
          )
        ),
      ),
    );
  }
}