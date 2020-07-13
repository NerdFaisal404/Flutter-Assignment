import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/user.dart';
import 'package:localstorage/localstorage.dart';

class UserProvider with ChangeNotifier {
  bool loggedIn = false;
  String message;
  User user;

  UserProvider() {
    getUser();
  }

  void createUser(
      {firstName,
      lastName,
      email,
      password,
      Function success,
      Function fail}) async {
    bool status = false;
    if (status) {
      loggedIn = true;
      success(true);
    } else {
      success(false);
    }
  }

  void logout() async {
    notifyListeners();
  }




  void saveUser(User user) async {
    final LocalStorage storage = new LocalStorage("fassignment");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("userInfo", user);
      }
    } catch (err) {
      print(err);
    }
  }

  void getUser() async {
    final LocalStorage storage = new LocalStorage("fassignment");
    try {
      final ready = await storage.ready;

      if (ready) {
        final json = storage.getItem("fassignment");
        if (json != null) {
          user = User.fromLocalJson(json);
          loggedIn = true;
        }
      }
    } catch (err) {
      print(err);
    }
  }
}
