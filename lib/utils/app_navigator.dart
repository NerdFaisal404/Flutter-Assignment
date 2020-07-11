import 'package:flutter/material.dart';
import 'package:flutter_assignment/anim/transition/slide_route.dart';

class AppNavigator {
  static void gotoIntroPage(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }

  static void gotoHomePage(BuildContext context) {
   // Navigator.pushReplacement(context, SlideLeftRoute(page: HomeScreen()));
  }

  static void gotoLogin(BuildContext context) {
  //  Navigator.pushReplacement(context, SlideLeftRoute(page: LoginScreen()));
  }

  static void gotoSignup(BuildContext context) {
    Navigator.pushNamed(context, "/signup");
  }



}