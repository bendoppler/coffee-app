import 'dart:collection';

import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/models/food.dart';
import 'package:cafe_app/models/order.dart';
import 'package:cafe_app/pages/map_page.dart';
import 'package:cafe_app/widgets/utils/color.dart';
import 'package:cafe_app/widgets/utils/snack_bar.dart';
import 'package:flutter/material.dart';


class ShoppingCartScreen extends StatelessWidget{
  final _orderBloc;
  ShoppingCartScreen(this._orderBloc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
          Text(
            AppLocalizations.of(context).cart,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff303030)
            ),
          ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: StreamBuilder<Order>(
                initialData: new Order(),
                stream: _orderBloc.orderStream,
                builder: (context, snapshot) {
                  return Row(
                    children: snapshot.requireData.foodMap.values
                      .map((food) => _buildFoodItemCart(food, context))
                      .toList(),
                  );
                }
              ),
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                  child: Text(
                    AppLocalizations.of(context).deliveryAddress,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: getColor1(context),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 150.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MapScreen(orderBloc: _orderBloc)
                        ));
                      },
                      child: Text(
                        AppLocalizations.of(context).addAddress,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                ),
              ),
            ]
          ),
          StreamBuilder<Order>(
            stream: _orderBloc.orderStream,
            builder: (context, snapshot) {
              if(snapshot.data == null || snapshot.data.address == null){
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context).noAddress,
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              }else if (snapshot.data.address.isNotEmpty) {
                return Container(
                  width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.15,
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.75,
                          height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              snapshot.data.address,
                              maxLines: 2,
                              style: TextStyle(
                                color: Color(0xff939393),
                                fontFamily: 'Roboto',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                height: 1.5
                              ),
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Color(0xff000000),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color(0xff8f8f8f),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                  child: Text(
                    AppLocalizations.of(context).paymentMethod,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: getColor1(context),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 90.0),
                  child: GestureDetector(
                    onTap: (){
                      //TODO: credit card screen
                    },
                    child: Text(
                      AppLocalizations.of(context).addCreditCard,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  _buildPaymentCard(context)
                ],
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).cart,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff939393),
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                    ),
                    Text(
                      AppLocalizations.of(context).promotion,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff939393),
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                    ),
                    Text(
                      AppLocalizations.of(context).deliveryFee,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff939393),
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                    ),
                    Text(
                      AppLocalizations.of(context).total,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Color(0xff939393),
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      StreamBuilder<String>(
                        stream: _orderBloc.billStream,
                        builder: (context, snapshot) {
                          if(snapshot.data==null){
                            return Text(
                              '10.000 vnd',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff939393)
                              ),
                            );
                          }else{
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff939393)
                              ),
                            );
                          }
                        }
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      Text(
                        "- 0.000 vnđ",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff939393),
                          fontSize: 16.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      Text(
                        'Miễn phí',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff939393),
                          fontSize: 16.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      StreamBuilder<String>(
                        stream: _orderBloc.billStream,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff939393)
                            ),
                          );
                        }
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
              height: MediaQuery.of(context).size.height*0.055,
              minWidth: MediaQuery.of(context).size.width * 0.9,
              child: StreamBuilder<Order>(
                stream: _orderBloc.orderStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                    color: Color(0xffffce50),
                    onPressed: () async{
                      if(snapshot.data==null || snapshot.data.address == null || snapshot.data.address.isEmpty){
                        WidgetsBinding.instance.addPostFrameCallback((_)=>showErrorSnackbar(
                          context,
                          message: "Bạn chưa có địa chỉ nhận hàng. Xin vui lòng thêm địa chỉ nhận hàng.",
                          duration: Duration(seconds: 3)));
                      }else{
                        await _orderBloc.postOrder();
                        Navigator.popUntil(context, ((r)=>r.isFirst));
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).orderConfirmation,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0
                      ),
                    )
                  );
                }
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _buildFoodItemCart(Food food, final BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.all(4.0),
      width: width*0.95,
      height: height*0.15,
      child: Stack(
        children: <Widget>[
          Positioned(
            left:width*0.1,
            top: 8.0,
            bottom: 8.0,
            right: 4.0,
            child: Container(
              width: width*0.8,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          food.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: getColor1(context),
                            fontStyle: FontStyle.normal
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                        ),
                        Text(
                          'Size S',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: getColor1(context),
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                        ),
                        Text(
                          food.price.toString() + ' vnđ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 130.0),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: getColor1(context),
                          ),
                          onPressed: () {
                            _orderBloc.idSink.add(food.id);
                            _orderBloc.addQuantityToFood(1);
                            _orderBloc.handleBillString();
                          },
                        ),
                        StreamBuilder<HashMap<String, int>>(
                          initialData: new HashMap(),
                          stream: _orderBloc.numberOfFoodMapStream,
                          builder: (context, snapshot) {
                            _orderBloc.id = food.id;
                            return Text(
                              snapshot.data[food.id].toString(),
                              style: TextStyle(
                                color: getColor1(context),
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                              ),
                            );
                          }
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: getColor1(context),
                            ),
                            onPressed: () {
                              _orderBloc.idSink.add(food.id);
                              _orderBloc.addQuantityToFood(-1);
                              _orderBloc.handleBillString();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: width*0.02,
            top: 16.0,
            bottom: 16.0,
            child: Container(
              width: width*0.2,
              height: height*0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                image: DecorationImage(
                  image: NetworkImage(food.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:10.0, top: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width*0.75,
        height: MediaQuery.of(context).size.height*0.1,
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.white,
              offset: new Offset(2.0, 2.0),
              blurRadius: 20.0
            )
          ],
          border: Border.all(
            color: Colors.black12
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context).payWhenReceive,
            style: TextStyle(
              color: getColor1(context),
              fontSize: 16.0,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}