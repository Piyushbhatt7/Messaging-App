import 'package:chatt_app/core/common/custom_button.dart';
import 'package:chatt_app/core/common/custom_text_field.dart';
import 'package:chatt_app/presentation/screens/auth/login_screen.dart';
import 'package:flutter/gestures.dart';
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
        appBar: AppBar(),
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

                const SizedBox(height: 8.0),

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
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                ),

                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),

                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: phoneController,
                  hintText: "Phone no.",
                  prefixIcon: Icon(Icons.phone_outlined),
                ),

                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility),
                  obscureText: true,
                ),

                const SizedBox(height: 30.0),

                CustomButton(onPressed: ()
                {
                  
                },
                text: "Create Account",
                ),

                RichText(text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),

                  children: [
                    TextSpan(
                      text: "Login",
                      style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => const LoginScreen()
                            )
                            );
                      }
                    )
                  ]
                ))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
