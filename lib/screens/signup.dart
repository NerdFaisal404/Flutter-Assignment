import 'package:flutter/material.dart';
import 'package:flutter_assignment/library/sweet_alert_dialog/sweet_alert_dialogs.dart';
import 'package:flutter_assignment/utils/constant.dart';
import 'package:flutter_assignment/utils/custom_dialog.dart';
import 'package:flutter_assignment/utils/dimens_constant.dart';
import 'package:flutter_assignment/utils/raised_gradient_button.dart';
import 'package:flutter_assignment/utils/shared_preferences_keys.dart';
import 'package:flutter_assignment/utils/utils.dart';
import 'package:flutter_assignment/utils/view/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _firstName, _lastName, _email, _password;
  bool _isLoading = false;
  SharedPreferences sharedPreferences;
  ProgressDialog _pd;

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
      body:/* _isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Utils.hexToColor(ColorsConstant.LOGIN_BACKGROUND)),
            ))
          : */Center(
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.twenty_dp),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "images/app_logo.png",
                            width: Dimens.ABOUT_US_LOGO_SIE,
                            height: Dimens.ABOUT_US_LOGO_SIE,
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
      showProgressDialog(true);
      CustomDialog.showCustomDialog(context, Constant.SUCCESS,
          Constant.REGISTRATION_SUCCESS_CONTENT, RichAlertType.SUCCESS);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<Widget> saveUserInfo(
      String firstNamer, String lastName, String email, String password) async {
    sharedPreferences.setString(
        SharedPreferencesKeys.KEY_FIRST_NAME, firstNamer);
    sharedPreferences.setString(SharedPreferencesKeys.KEY_LAST_NAME, lastName);
    sharedPreferences.setString(SharedPreferencesKeys.KEY_EMAIL, _email);
    sharedPreferences.setString(SharedPreferencesKeys.password, password);
  }


  void showProgressDialog(bool needToSHow) {
    if (needToSHow) {
      _pd = ProgressDialog(context);

      _pd.style(
          message: "Please wait...",
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          elevation: 10.0,
          progress: 0.0,
          maxProgress: 100.0,
          progressWidget: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          progressTextStyle: TextStyle(
              color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 19.0,
              fontWeight: FontWeight.w600));

      _pd.show();
    }else{
      _pd.hide();
    }
  }
}
