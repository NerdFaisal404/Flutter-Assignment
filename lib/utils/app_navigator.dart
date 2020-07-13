import 'package:flutter/material.dart';
import 'package:flutter_assignment/anim/transition/slide_route.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/login_screen.dart';

class AppNavigator {

  static void gotoHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void gotoLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  static void gotoSignup(BuildContext context) {
    Navigator.pushNamed(context, "/signup");
  }



}