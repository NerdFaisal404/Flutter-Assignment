import 'package:flutter/material.dart';

class AppNavigator {

  static void gotoHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home_screen");
  }

  static void gotoLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/Login_screen");
  }

  static void gotoSignup(BuildContext context) {
    Navigator.pushNamed(context, "/signup_screen");
  }



}