import 'package:flutter/material.dart';
Widget buildErrorWidget(String error, BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error", style: Theme.of(context).textTheme.subtitle),
      ],
    ));
}