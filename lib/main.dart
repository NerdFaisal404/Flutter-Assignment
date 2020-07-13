import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/login_screen.dart';
import 'package:flutter_assignment/screens/signup.dart';
import 'package:flutter_assignment/screens/splash_screen.dart';
import 'package:flutter_assignment/theme/themes.dart';
//Page route setup
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/Login": (BuildContext context) => LoginScreen(),
  "/signup": (BuildContext context) => Signup(),
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

