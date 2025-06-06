import 'package:chatt_app/core/common/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create an Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10.0),

                Text(
                  "Please fill the details to continue",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),

                const SizedBox(height: 30.0),

                CustomTextField(
                  controller: nameController,
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),

                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: usernameController,
                  hintText: "Username",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),

                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),

                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: phoneController,
                  hintText: "Phone no.",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),

                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),

                const SizedBox(height: 16.0),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
