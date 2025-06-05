import 'package:chatt_app/core/common/custom_button.dart';
import 'package:chatt_app/core/common/custom_text_field.dart';
import 'package:flutter/gestures.dart';
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
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0,),
                Text(
                  "Welcome Back", 
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
          
                 const SizedBox(height: 30.0,),
                     // email
                CustomTextField(
                  controller: emailController, 
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  ),
          
                  const SizedBox(height: 14.0,),
                     // password
                   CustomTextField(
                  controller: passwordController, 
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility),
                  obscureText: true,
                  ),
          
                   const SizedBox(height: 30.0,),
                   CustomButton(
                    onPressed: ()
                   {
                     
                   }, text: "Login",
                   ),

                   const SizedBox(height: 20.0,),

                   Center(
                     child: RichText(
                      text:  TextSpan(
                        text:  "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey[600]
                        ),
              
                        children: [
                          TextSpan(
                            text: "SignUp",
                            style: Theme.of(context)
                            .textTheme.bodyLarge
                            ?.copyWith(
                              color: Theme.of(context)
                              .primaryColor, 
                              fontWeight: FontWeight.bold,
                              ),     
                              recognizer: TapGestureRecognizer(
                                
                              ) 
                          ),
                        ]
                      ),                              
                     ),
                   )
              ],
            )
          ),
        ),
      ),
    );
  }
}