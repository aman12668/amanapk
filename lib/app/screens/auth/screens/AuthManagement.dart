import 'package:ENEB_HUB/app/screens/auth/screens/Login_Register.dart';
import 'package:ENEB_HUB/app/screens/main/screens/tabs/curve_navigation_bar.dart';
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
              return const Tabs();
            } else {
              return const LoginandRegister();
            }
          }),
    );
  }
}
