import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/widgets/utils/text_box.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: textBox(
        context,
        hintText: AppLocalizations.of(context).time,
        borderRadius: 8.0,
        hintStyle: TextStyle(
          color: Theme
            .of(context)
            .brightness == Brightness.light
            ? Color(0xFF424242)
            : Colors.white
        ),
        fillColor:
        Theme
          .of(context)
          .brightness == Brightness.light
          ? Colors.white
          : Color(0xFF424242),
        enabled: false
      ),
    );

  }
}