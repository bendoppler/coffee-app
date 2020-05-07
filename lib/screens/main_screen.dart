import 'package:cafe_app/blocs/application_bloc.dart';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/widgets/food_news_scrollview.dart';
import 'package:cafe_app/widgets/promos_news_listview.dart';
import 'package:cafe_app/widgets/user_info.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return StreamBuilder<Color>(
      initialData: Color(0xffeeeeee),
      stream: _applicationBloc.containerColor,
      builder: (context, snapshot) {
        return Container(
          color: snapshot.data,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //user info
                UserInfo(),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color(0xFF303030),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //promo news and food news
                      PromosNews(),
                      FoodNews()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}