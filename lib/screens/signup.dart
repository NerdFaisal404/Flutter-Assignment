import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/library/sweet_alert_dialog/sweet_alert_dialogs.dart';
import 'package:flutter_assignment/utils/app_navigator.dart';
import 'package:flutter_assignment/utils/colors.dart';
import 'package:flutter_assignment/utils/constant.dart';
import 'package:flutter_assignment/utils/custom_dialog.dart';
import 'package:flutter_assignment/utils/dimens_constant.dart';
import 'package:flutter_assignment/utils/raised_gradient_button.dart';
import 'package:flutter_assignment/utils/shared_preferences_keys.dart';
import 'package:flutter_assignment/utils/utils.dart';
import 'package:flutter_assignment/utils/view/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _firstName, _lastName, _email, _password;
  SharedPreferences sharedPreferences;
  ProgressDialog _pd;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    initPreference();
    super.initState();
  }

  Future<Null> initPreference() async {
    await SharedPreferences.getInstance().then((onValue) {
      setState(() {
        sharedPreferences = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.SIGN_UP_TITLE),
      ),
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.twenty_dp),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: _showImagePickerDialog,
                      child: Container(
                        margin: EdgeInsets.all(Dimens.ten_dp),
                        width: Dimens.HOME_CATEGORY_CIRCULAR,
                        height: Dimens.HOME_CATEGORY_CIRCULAR,
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 46.0,
                          backgroundImage: _image == null
                              ? AssetImage("images/ic_add_photo.png")
                              : FileImage(_image),
                        ),
                      ),
                    ),
                    CustomTextField(
                      validator: (input) =>
                          input.isEmpty ? Constant.REQUIRED : null,
                      onSaved: (input) => _firstName = input,
                      hint: Constant.FIRST_NAME,
                    ),
                    SizedBox(height: Dimens.ten_dp),
                    CustomTextField(
                      validator: (input) =>
                          input.isEmpty ? Constant.REQUIRED : null,
                      onSaved: (input) => _lastName = input,
                      hint: Constant.LAST_NAME,
                    ),
                    SizedBox(height: Dimens.ten_dp),
                    CustomTextField(
                      onSaved: (input) {
                        _email = input;
                      },
                      validator: Utils.emailValidator,
                      hint: Constant.EMAIL,
                    ),
                    SizedBox(height: Dimens.ten_dp),
                    CustomTextField(
                      obsecure: true,
                      onSaved: (input) => _password = input,
                      validator: (input) =>
                          input.isEmpty ? Constant.REQUIRED : null,
                      hint: Constant.PASSWORD,
                    ),
                    SizedBox(
                      height: Dimens.twenty_dp,
                    ),
                    RaisedGradientButton(
                        width: double.infinity,
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.eighteen_dp,
                              fontWeight: FontWeight.w600),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color.fromRGBO(221, 202, 127, 1),
                            Color.fromRGBO(198, 202, 67, 1),
                          ],
                        ),
                        onPressed: () {
                          _validateRegisterInput();
                        }),
                    SizedBox(
                      height: Dimens.ten_dp,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(context),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimens.eight_dp,
                            right: Dimens.eight_dp,
                            top: Dimens.eight_dp),
                        width: double.infinity,
                        child: Text(
                          Constant.ALREADY_REGISTERED,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void _validateRegisterInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      saveUserInfo(_firstName, _lastName, _email, _password);
      showCustomDialog("Registration Successfully Done");
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<Widget> saveUserInfo(
      String firstName, String lastName, String email, String password) async {
    sharedPreferences.setString(
        SharedPreferencesKeys.KEY_FIRST_NAME, firstName);
    sharedPreferences.setString(SharedPreferencesKeys.KEY_LAST_NAME, lastName);
    sharedPreferences.setString(SharedPreferencesKeys.KEY_EMAIL, email);
    sharedPreferences.setString(SharedPreferencesKeys.password, password);
    sharedPreferences.setString(SharedPreferencesKeys.imagePath, "$_image");
  }


  void showCustomDialog(String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle("Success"),
            alertSubtitle: richSubtitle(content),
            alertType: RichAlertType.SUCCESS,
            actions: <Widget>[
              RaisedButton(
                child: Text("OK"),
                onPressed: () {
                  AppNavigator.gotoLogin(context);
                },
              ),
            ],
          );
        });
  }

  void _showImagePickerDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select the image source"),
            actions: <Widget>[
              MaterialButton(
                child: Text("Camera"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getImageFromCamera();
                },
              ),
              MaterialButton(
                child: Text("Gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getImageFromGallery();
                },
              )
            ],
          );
        });
  }

  Future getImageFromCamera() async {
    final image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  Future getImageFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

}
