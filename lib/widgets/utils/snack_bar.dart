import 'package:flutter/material.dart';
void showErrorSnackbar(BuildContext context,
  {String message, SnackBarAction action, Duration duration}) =>
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Row(
      children: <Widget>[
        Icon(Icons.error),
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              message,
              maxLines: 2,
            ),
          ),
        )
      ],
    ),
    action: action,
    duration: duration));