import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/models/news.dart';
import 'package:flutter/material.dart';

class FoodNews extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context).news,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: News.mockNewsList
              .map((news) => buildNewsTile(context, news))
              .toList(),
          ),
        )
      ],
    );
  }

  /// Build the news tile
  Widget buildNewsTile(context, News news) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        child: Column(
          children: <Widget>[
            Container(
              height: 256.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(news.banner),
                  fit: BoxFit.fitWidth),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
            ),
            Container(
              height: 150.0,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      news.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(fontSize: 16.0),
                    ),
                  ),
                  Text(
                    news.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.body1,
                  )
                ],
              ),
            )
          ],
        ),
        onTap: () {
          //TODO::news details widget
        },
        borderRadius: BorderRadius.circular(8.0),
      )),
  );
}