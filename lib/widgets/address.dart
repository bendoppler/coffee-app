import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/pages/map_page.dart';
import 'package:cafe_app/widgets/utils/text_box.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget{
  final orderBloc;
  AddressWidget(this.orderBloc);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: textBox(
            context,
            hintText: AppLocalizations.of(context).address,
            hintStyle: TextStyle(
              color: Theme
                .of(context)
                .brightness == Brightness.light
                ? Color(0xFF424242)
                : Colors.white
            ),
            borderRadius: 8.0,
            fillColor: Theme
              .of(context)
              .brightness == Brightness.light
              ? Colors.white
              : Color(0xFF424242),
            enabled: false,
          ),
          onTap: () {
            //await _orderBloc.getUserLocation();
            Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MapScreen(orderBloc: orderBloc)));
          }
        )
      )
    );
  }
}