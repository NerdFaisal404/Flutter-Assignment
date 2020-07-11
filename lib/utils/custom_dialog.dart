import 'package:flutter/material.dart';
import 'package:flutter_assignment/library/sweet_alert_dialog/sweet_alert_dialogs.dart';

class CustomDialog {
  static void showCustomDialog(
      BuildContext context, String title, String content, int state) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle(title),
            alertSubtitle: richSubtitle(content),
            alertType: state,
            actions: <Widget>[
              RaisedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
