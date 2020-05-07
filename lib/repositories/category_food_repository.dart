

import 'package:cafe_app/api_providers/category_food_provider.dart';
import 'package:cafe_app/responses/category_food_response.dart';

class CategoryFoodRepository{
  String id;
  //var _categoryApiProviders = <CategoryFoodApiProvider>[];
  Future<CategoryFoodResponse> getFoodListBasedOnCategory(){
    CategoryFoodApiProvider categoryFoodApiProvider = CategoryFoodApiProvider(id);
    //_categoryApiProviders.add(categoryFoodApiProvider);
    return categoryFoodApiProvider.getFoodListBasedOnCategory();
  }
}