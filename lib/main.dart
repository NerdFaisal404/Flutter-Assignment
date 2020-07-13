import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/login_screen.dart';
import 'package:flutter_assignment/screens/signup_screen.dart';
import 'package:flutter_assignment/screens/splash_screen.dart';
import 'package:flutter_assignment/theme/themes.dart';
//Page route setup
var routes = <String, WidgetBuilder>{
  "/home_screen": (BuildContext context) => HomeScreen(),
  "/Login_screen": (BuildContext context) => LoginScreen(),
  "/signup_screen": (BuildContext context) => SignupScreen(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getDarkTheme(),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home:SplashScreen(),
    );
  }
}

