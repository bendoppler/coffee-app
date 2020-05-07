import 'package:cafe_app/models/food.dart';


class SizeFoodResponse{
  final List<Food> foodList;
  final String error;

  SizeFoodResponse(this.foodList, this.error);

  SizeFoodResponse.fromJson(Map<String, dynamic> json)
    :foodList =
  (json["data"] as List).map((food)=> new Food.fromSizeJson(food)).toList(),
      error = "";

  SizeFoodResponse.withError(String errorValue)
    : foodList = List(),
      error = errorValue;
}