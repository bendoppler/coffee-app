import 'package:cafe_app/models/food.dart';

class CategoryFoodResponse{
  final List<Food> foods;
  final String error;

  CategoryFoodResponse(this.foods, this.error);

  CategoryFoodResponse.fromJson(Map<String, dynamic> json)
    :foods =
  (json["data"] as List).map((food) => new Food.fromJson(food)).toList(),
      error = "";

  CategoryFoodResponse.withError(String errorValue)
    : foods = List(),
      error = errorValue;
}