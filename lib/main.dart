import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'pages/main_menu_page.dart';
import 'pages/quiz/quiz_page.dart';
import 'pages/ar_page.dart';
import 'pages/learn/material_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR Solar System',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF9C4), // Soft yellow
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Poppins',
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
      home: const AuthGate(), // This is the new part
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const MainMenuPage(); // Logged in
        } else {
          return const LoginPage(); // Not logged in
        }
      },
    );
  }
}
