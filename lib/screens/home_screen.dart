import 'package:flutter/material.dart';
import 'package:flutter_assignment/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.HOME_TITLE),
      ),
      body: Container(),
    );
  }
}
