import 'package:ENEB_HUB/App/Screens/Authentication/LoginScreen.dart';
import 'package:ENEB_HUB/App/Screens/Authentication/SignUpScreen.dart';
import 'package:flutter/material.dart';

class LoginandRegister extends StatefulWidget {
  const LoginandRegister({super.key});

  @override
  State<LoginandRegister> createState() => _LoginandRegisterState();
}

class _LoginandRegisterState extends State<LoginandRegister> {
//initially show the login page

  bool showLoginPage = true;

// toggle between login and regidter page

  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: tooglePages,
      );
    } else {
      return SignUpScreen(onTap: tooglePages);
    }
  }
}
