import 'package:chatt_app/core/common/custom_button.dart';
import 'package:chatt_app/core/common/custom_text_field.dart';
import 'package:chatt_app/core/utils/ui_utils.dart';
import 'package:chatt_app/data/services/service_locator.dart';
import 'package:chatt_app/logic/cubits/auth/auth_cubit.dart';
import 'package:chatt_app/logic/cubits/auth/auth_state.dart';
import 'package:chatt_app/presentation/home/home_screen.dart';
import 'package:chatt_app/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  final _nameFocus = FocusNode();
  final _usernameFocus = FocusNode(); // 1:20:23
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();

    _nameFocus.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your full name";
    }
    return null;
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a username";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email address";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address (e.g, example@gmail.com)';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone no.";
    }

    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +91 9357598)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

   Future<void> handleSignUp() async {

    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      try{
      await getIt<AuthCubit>().signUp(
          fullName: nameController.text, 
          username: usernameController.text, 
          email: emailController.text, 
          phoneNumber: phoneController.text, 
          password: passwordController.text
          );
      }
      catch(e)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))); 
      }
    }
    else{
      print("form validation failed");
    }
   }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
    bloc: getIt<AuthCubit>(),
    listener: (context, state) {
      if(state.status == AuthStatus.authenticated)
      {
        getIt<AppRouter>().pushAndRemoveUntil(const HomeScreen()); // 3:25
      }
    
      else if(state.status == AuthStatus.error && state.error != null)
      {
        UiUtils.showSnackBar(
          context, message: state.error!
        );
      }
    },
      builder:(context, state) {
    
      return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
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
                  focusNode: _nameFocus,
                  hintText: "Full Name",
                  validator: _validateName,
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
      
                const SizedBox(height: 16.0),
      
                CustomTextField(
                  controller: usernameController,
                  hintText: "Username",
                  focusNode: _usernameFocus,
                  validator: _validateUserName,
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                ),
      
                const SizedBox(height: 16.0),
      
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  focusNode: _emailFocus,
                  validator: _validateEmail,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
      
                const SizedBox(height: 16.0),
      
                CustomTextField(
                  controller: phoneController,
                  hintText: "Phone no.",
                  focusNode: _phoneFocus,
                  validator: _validatePhone,
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
      
                const SizedBox(height: 16.0),
      
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  focusNode: _passwordFocus,
                  validator: _validatePassword,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                    _isPasswordVisible
                    ? Icons.visibility_off 
                    :  Icons.visibility
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                ),
      
                const SizedBox(height: 30.0),
      
                CustomButton(
                  onPressed: handleSignUp,
                  text: "Create Account",
                ),
      
                const SizedBox(height: 20),
      
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account?  ",
                      style: TextStyle(color: Colors.grey[600]),
      
                      children: [
                        TextSpan(
                          text: "Login",
                          style: Theme.of(
                            context, 
                          ).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      }
    );
  }
}
