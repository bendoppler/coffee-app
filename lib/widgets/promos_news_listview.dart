
import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/models/news.dart';
import 'package:flutter/material.dart';

class PromosNews extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context).promotions,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.0,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: News.mockNewsList
                .map((news) => buildPromoNewsTitle(news))
                .toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPromoNewsTitle(News news) {
    return Container(
      width: 220.0,
      height: 210.0,
      child: Card(
        shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          child: Column(
            children: <Widget>[
              Container(
                width: 220.0,
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(news.banner),
                    fit: BoxFit.fitWidth
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  news.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              )
            ],
          ),
          onTap: () {},
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}