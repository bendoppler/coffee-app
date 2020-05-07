import 'package:flutter/material.dart';

Widget textBox(BuildContext context,
  {String labelText,
    TextInputType keyboardType = TextInputType.text,
    String hintText,
    bool enabled = true,
    int maxLines = 1,
    FormFieldValidator<String> validator,
    TextEditingController controller,
    TextStyle style,
    String suffixText,
    Widget suffix,
    double borderRadius = 0.0,
    Color fillColor,
    Color primaryColor,
    Color disabledColor,
    TextStyle labelStyle,
    TextStyle hintStyle,
    FocusNode focusNode,
    bool obscureText = false,
    bool autoValidate = false}) =>
  Theme(
    data: Theme.of(context).copyWith(
      disabledColor: disabledColor,
      primaryColor: primaryColor ?? Theme.of(context).primaryColor,
      hintColor: Colors.grey[300]),
    child: TextFormField(
      focusNode: focusNode,
      enabled: enabled,
      validator: validator,
      autovalidate: autoValidate,
      obscureText: obscureText,
      style: style,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        labelText: labelText,
        hintText: hintText,
        labelStyle: labelStyle ?? Theme.of(context).textTheme.body1,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
        suffixText: suffixText,
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(borderRadius))),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide:
          BorderSide(color: Theme.of(context).primaryColor))),
      keyboardType: keyboardType,
      maxLines: maxLines,
      controller: controller,
    ));