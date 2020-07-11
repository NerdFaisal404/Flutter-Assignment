import 'package:flutter/material.dart';
import 'package:flutter_assignment/anim/transition/slide_route.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/login_screen.dart';

class AppNavigator {

  static void gotoHomePage(BuildContext context) {
    Navigator.pushReplacement(context, SlideLeftRoute(page: HomeScreen()));
  }

  static void gotoLogin(BuildContext context) {
    Navigator.pushReplacement(context, SlideLeftRoute(page: LoginScreen()));
  }

  static void gotoSignup(BuildContext context) {
    Navigator.pushNamed(context, "/signup");
  }



}