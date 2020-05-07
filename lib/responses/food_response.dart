import 'package:cafe_app/models/food.dart';

class FoodResponse{
  final Food food;
  final String error;

  FoodResponse(this.food, this.error);

  FoodResponse.fromJson(Map<String, dynamic> json)
    :food = new Food.fromJson(json),
      error = "";

  FoodResponse.withError(String errorValue)
    : food = Food(),
      error = errorValue;
}