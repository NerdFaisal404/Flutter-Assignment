class User {
  bool loggedIn;
  bool status;


  //  User login response
  User.fromAuthUser(Map<String, dynamic> json) {
    try {
      status = json['successful'];
      loggedIn = true;
      print("user login info: " + json.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  User.fromLocalJson(Map<String, dynamic> json) {
    try {
      status = json['successful'];
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
