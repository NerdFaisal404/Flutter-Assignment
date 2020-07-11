import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  FocusNode _myFocusNode = new FocusNode();

  CustomTextField(
      {this.hint,
      this.obsecure = false,
      this.validator,
      this.onSaved,
      this.controller,
      this.onChanged,
      this.labelText,
      this.inputType,
      this.autoFocus = true});

  final FormFieldSetter<String> onSaved;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final bool autoFocus;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: inputType,
        focusNode: _myFocusNode,
        onSaved: onSaved,
        validator: validator,
        autofocus: autoFocus,
        obscureText: obsecure,
        style: new TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: "Heebo",
            color: Colors.grey),
        decoration: InputDecoration(
          hintText: hint,
          labelText: labelText,
          labelStyle: TextStyle(
              color: _myFocusNode.hasFocus ? Colors.white : Colors.white),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.5),
          ),
        ),
      ),
    );
  }
}
