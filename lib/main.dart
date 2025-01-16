import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'forgotPassword.dart';
import 'interestsScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login & Sign up',
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgotPassword' : (context) => const ForgetPasswordScreen(),
        '/interestsScreen' : (context) => const InterestsScreen(),
        '/home_screen' : (context) => const HomeScreen(),
      },
    );
  }
}
