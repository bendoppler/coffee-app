import 'package:cafe_app/blocs/application_bloc.dart';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/lang/localizations.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          height: 150.0,
        ),
        Column(
          children: <Widget>[
            Padding(
              //decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Card(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=845&q=80"),
                            radius: 30.0,
                          ),
                          elevation: 4.0,
                          shape: CircleBorder(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 1.0),
                                      child: Text(
                                        "Tuan Luu",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff303030)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 1.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Thanh vien ngu",
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff303030)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 10.0,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          Text(
                                            "4000 diem",
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff303030)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Image.asset(
                                  'assets/icons/icon_qr.png',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  AppLocalizations.of(context).barcode,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
//                                    color:  Theme.of(context).primaryColor
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 1.0,
                      color: Colors.grey[200],
                      height: 80.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Image.asset(
                                  'assets/icons/icon_shopping_2.png',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  AppLocalizations.of(context).order,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
//                                    color: Color(0xff303030)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: (){
                          _applicationBloc.pickItem(1);
                          _applicationBloc.barItem.add(NavigationBarItem.ORDER);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 1.0,
                      color: Colors.grey[200],
                      height: 80.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, right: 8.0),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Image.asset(
                                  'assets/icons/icon_coupon.png',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  AppLocalizations.of(context).coupon,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}