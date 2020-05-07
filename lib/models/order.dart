import 'dart:collection';

import 'package:cafe_app/models/food.dart';
import 'package:cafe_app/models/size_food.dart';


class Order {
  String id, createdTime, lastModifiedTime, address, status;
  int price, stars;
  double longitude, latitude;

  //List<Promotion> promotions;
  HashMap<String, Food> foodMap;

  Order({this.foodMap, this.price, this.longitude, this.latitude, this.address}) {
    this.price = 0;
    this.foodMap =  new HashMap();
  }

  Map<String, dynamic> toJson() {
    String date = DateTime.now().toString();
    List<Map<String,dynamic>> foodJsonArray = foodMap.values.map((food){
      return food.toJson();
    }).toList();
    print('food json: '+ foodJsonArray.toString());
    return {
      'order':{
        'customerId': 'bao-bo-bo',
        'createdTime': date,
        'lastModifiedTime': date,
        'address': address,
        'price': price,
        'latitude': latitude,
        'longitude': longitude
      },
      'foodInfo' : foodJsonArray
    };
  }
}