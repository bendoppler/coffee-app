import 'dart:collection';

import 'package:cafe_app/blocs/order_bloc.dart';
import 'package:cafe_app/models/food.dart';
import 'package:cafe_app/models/size_food.dart';
import 'package:cafe_app/responses/size_food_response.dart';
import 'package:cafe_app/widgets/utils/color.dart';
import 'package:cafe_app/widgets/utils/currency.dart';
import 'package:cafe_app/widgets/utils/loading.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
  final OrderBloc orderBloc;

  ItemDetailsScreen(this.orderBloc);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(context),
        leading: GestureDetector(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: getColor1(context),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          widget.orderBloc.foodInfo.title,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: getColor(context),
              fontStyle: FontStyle.normal),
        )),
      body: StreamBuilder<SizeFoodResponse>(
        stream: widget.orderBloc.sizeFoodListStream,
        builder: (context, snapshot1) {
          if(snapshot1.data!=null && snapshot1.hasData) {
            return Column(
              children: <Widget>[
                Container(
                  width: _size.width,
                  height: _size.height * 0.25,
                  child: Image.network(
                    widget.orderBloc.foodInfo.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 20.0),
                    child: Text(
                      widget.orderBloc.foodInfo.title,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 20.0),
                    child: Text(
                      widget.orderBloc.foodInfo.description,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0, left: 24.0, right: 24.0),
                  child: Divider(
                    color: getColor1(context),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 20.0),
                    child: Text(
                      'Chọn size',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                      child: StreamBuilder<int>(
                        initialData: 0,
                        stream: widget.orderBloc.radioStream,
                        builder: (context, snapshot) {
                          return Radio(
                            value: 0,
                            groupValue: snapshot.data,
                            onChanged: widget.orderBloc.handleSizeValueChange,
                          );
                        }),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 20.0),
                        child: Text(
                          'Size S',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 164.0),
                        child: Text(
                          convertIntToString(
                            snapshot1.data.foodList[0].price) +
                            ' vnđ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                      child: StreamBuilder<int>(
                        stream: widget.orderBloc.radioStream,
                        builder: (context, snapshot) {
                          return Radio(
                            value: 1,
                            groupValue: snapshot.data,
                            onChanged:
                            widget.orderBloc.handleSizeValueChange,
                          );
                        }),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 20.0),
                        child: Text(
                          'Size M',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 160.0),
                        child: Text(
                          convertIntToString(
                            snapshot1.data.foodList[1].price) +
                            ' vnđ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                      child: StreamBuilder<int>(
                        stream: widget.orderBloc.radioStream,
                        builder: (context, snapshot) {
                          return Radio(
                            value: 2,
                            groupValue: snapshot.data,
                            onChanged:
                            widget.orderBloc.handleSizeValueChange,
                          );
                        }),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 20.0),
                        child: Text(
                          'Size L',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 164.0),
                        child: Text(
                          convertIntToString(
                            snapshot1.data.foodList[2].price) +
                            ' vnđ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0, left: 24.0, right: 24.0),
                  child: Divider(
                    color: getColor1(context),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 20.0),
                    child: Text(
                      'Optional',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                      child: StreamBuilder<bool>(
                        initialData: false,
                        stream: widget.orderBloc.optionalStream,
                        builder: (context, snapshot) {
                          return Checkbox(
                            value: snapshot.data,
                            onChanged: widget
                              .orderBloc.handleOptionalValueChange,
                          );
                        })),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 20.0),
                        child: Text(
                          'Double shots',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 100.0),
                        child: Text(
                          '+ 10.000 vnđ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 4.0, left: 20.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: getColor1(context),
                            ),
                            onPressed: () {
                              widget.orderBloc.addQuantityToFood(-1);
                              widget.orderBloc.handleBillString();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                        child: StreamBuilder<HashMap<String, int>>(
                          stream: widget.orderBloc.numberOfFoodMapStream,
                          builder: (context, snapshot) {
                            if(snapshot.data == null){
                              return Text(
                                '1',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: getColor1(context),
                                  fontSize: 16.0),
                              );
                            }
                            if(snapshot.data!=null && snapshot.hasData){
                              return Text(
                                snapshot.data[widget.orderBloc.id].toString(),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: getColor1(context),
                                  fontSize: 16.0),
                              );
                            }else{
                              buildLoadingWidget(context);
                            }
                          }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: getColor1(context),
                          ),
                          onPressed: () {
                            widget.orderBloc.addQuantityToFood(1);
                            widget.orderBloc.handleBillString();
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 32.0),
                          child: RaisedButton(
                            color: Color(0xffffce50),
                            onPressed: () {
                              widget.orderBloc.addFoodToOrder();
                              Navigator.pop(context);
                            },
                            child: _getPrice(context)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }else{
            return buildLoadingWidget(context);
          }
        })
    );
  }

  Widget _getPrice(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.orderBloc.billStream,
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return Text(
              '10.000 vnđ',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: getColor1(context)),
            );
          }else{
            return Text(
              snapshot.data,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: getColor1(context)),
            );
          }
        });
  }
}
