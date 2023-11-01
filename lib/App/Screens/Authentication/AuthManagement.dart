import 'package:ENEB_HUB/App/Screens/Authentication/Login_Register.dart';
import 'package:ENEB_HUB/App/Screens/CoreApp/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen1();
            } else {
              return const LoginandRegister();
            }
          }),
    );
  }
}
