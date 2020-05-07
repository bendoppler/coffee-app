import 'package:flutter/material.dart';

Color getColor(BuildContext context){
  return Theme
    .of(context)
    .brightness == Brightness.light
    ? Colors.white
    : Color(0xFF303030);
}
Color getColor1(BuildContext context){
  return Theme
    .of(context)
    .brightness == Brightness.light
    ? Color(0xFF303030)
    : Colors.white;
}