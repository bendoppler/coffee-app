import 'package:flutter/material.dart';
Widget buildLoadingWidget(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Loading data from API...",
          style: Theme.of(context).textTheme.subtitle),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
      ],
    ));
}

