import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/library/sweet_alert_dialog/sweet_alert_dialogs.dart';
import 'package:flutter_assignment/models/user.dart';
import 'package:flutter_assignment/utils/app_navigator.dart';
import 'package:flutter_assignment/utils/colors.dart';
import 'package:flutter_assignment/utils/constant.dart';
import 'package:flutter_assignment/utils/custom_dialog.dart';
import 'package:flutter_assignment/utils/dimens_constant.dart';
import 'package:flutter_assignment/utils/raised_gradient_button.dart';
import 'package:flutter_assignment/utils/shared_preferences_keys.dart';
import 'package:flutter_assignment/utils/utils.dart';
import 'package:flutter_assignment/utils/view/custom_textfield.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _autoValidate = false;
  SharedPreferences sharedPreferences;
  ProgressDialog _pd;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
      resizeToAvoidBottomInset: true,
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
                  SizedBox(
                    height: 120,
                  ),

                  CustomTextField(
                    onSaved: (input) {
                      _email = input;
                    },
                    validator: Utils.emailValidator,
                    hint: Constant.EMAIL,
                    controller: _emailController,
                  ),

                  // Password field
                  SizedBox(height: Dimens.ten_dp),

                  CustomTextField(
                    obsecure: true,
                    onSaved: (input) => _password = input,
                    validator: (input) =>
                        input.isEmpty ? Constant.REQUIRED : null,
                    hint: Constant.PASSWORD,
                    controller: _passwordController,
                  ),

                  SizedBox(
                    height: Dimens.twenty_dp,
                  ),

                  RaisedGradientButton(
                    width: double.infinity,
                    child: Text(
                      Constant.LOGIN,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimens.eighteen_dp,
                          fontWeight: FontWeight.w600),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        ColorsConstant.LOGO_COLOR,
                        Color.fromRGBO(198, 202, 67, 1),
                      ],
                    ),
                    onPressed: () {
                      _validateLoginInput();
                    },
                  ),
                  SizedBox(
                    height: Dimens.ten_dp,
                  ),
                  GestureDetector(
                    onTap: () {
                      _passwordController.clear();
                      _emailController.clear();
                      AppNavigator.gotoSignup(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: Dimens.eight_dp,
                          right: Dimens.eight_dp,
                          top: Dimens.eight_dp),
                      width: double.infinity,
                      child: Text(
                        Constant.NOT_YET_ACCOUNT,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateLoginInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      setUserPrefValue();
      showCustomDialog("Login Successfully Done");
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }


  Future<Widget> setUserPrefValue() async {
    sharedPreferences.setBool(SharedPreferencesKeys.isLoggedIn, true);
    sharedPreferences.setString(
        SharedPreferencesKeys.KEY_EMAIL, _email.toLowerCase().trim());
    sharedPreferences.setString(
        SharedPreferencesKeys.password, _password.toLowerCase().trim());
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
                  AppNavigator.gotoHomePage(context);
                },
              ),
            ],
          );
        });
  }
}
