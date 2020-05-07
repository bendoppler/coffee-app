
import 'package:cafe_app/models/category.dart';

class CategoryResponse{
  final List<Category> categories;
  final String error;

  CategoryResponse(this.categories, this.error);

  CategoryResponse.fromJson(Map<String, dynamic> json)
  :categories =
  (json["data"] as List).map((category) => new Category.fromJson(category)).toList(),
  error = "";

  CategoryResponse.withError(String errorValue)
    : categories = List(),
      error = errorValue;
}