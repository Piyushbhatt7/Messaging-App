import 'package:chatt_app/config/theme/app_theme.dart';
import 'package:chatt_app/data/services/service_locator.dart';
import 'package:chatt_app/firebase_options.dart';
import 'package:chatt_app/logic/cubits/auth/auth_cubit.dart';
import 'package:chatt_app/logic/cubits/auth/auth_state.dart';
import 'package:chatt_app/presentation/chat/chat_message_screen.dart';
import 'package:chatt_app/presentation/home/home_screen.dart';
import 'package:chatt_app/presentation/screens/auth/login_screen.dart';
import 'package:chatt_app/presentation/screens/auth/signup_screen.dart';
import 'package:chatt_app/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
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
      navigatorKey: getIt<AppRouter>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Messenger App',
      theme: AppTheme.lightTheme,
      home: 
      // ChatMessageScreen(
      //   receiverId: 'sampleReceiverId',
      //   receiverName: 'Sample Receiver',
      // ),
       BlocBuilder<AuthCubit, AuthState>(
          bloc: getIt<AuthCubit>(),
          builder: (context, state) {
            if (state.status == AuthStatus.initial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            // You can customize the following logic as needed
            // For demonstration, redirect to HomeScreen if authenticated, else LoginScreen
            if (state.status == AuthStatus.authenticated) {
              return const HomeScreen();
            }
              return const LoginScreen();
          },
      ),
    ); 
  }
}
