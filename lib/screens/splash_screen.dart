import 'package:flutter/material.dart';
import 'package:flutter_assignment/utils/app_navigator.dart';
import 'package:flutter_assignment/utils/dimens_constant.dart';
import 'package:flutter_assignment/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      //Navigator.pop(context);
      gotoHome();
    });
  }

  gotoHome() async {
    initPreference();
  }

  Future<Null> initPreference() async {
    await SharedPreferences.getInstance().then((onValue) {
      bool isLogined = onValue.getBool(SharedPreferencesKeys.isLoggedIn);
      if (isLogined != null && isLogined) {
        AppNavigator.gotoHomePage(context);
      } else {
        // AppNavigator.gotoLogin(context);
        print("Login account load");
        AppNavigator.gotoLogin(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Image.asset(
//                "images/app_logo.png",
//                width: Dimens.ABOUT_US_LOGO_SIE,
//                height: Dimens.ABOUT_US_LOGO_SIE,
//              ),

              Text(
                "AxilWebApp",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )
            ],
          )
        ],
      ),
    );
  }
}
