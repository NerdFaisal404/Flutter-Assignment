class User {
  bool loggedIn;
  bool status;



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
