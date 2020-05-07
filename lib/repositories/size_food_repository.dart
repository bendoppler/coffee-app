
import 'package:cafe_app/api_providers/size_food_provider.dart';
import 'package:cafe_app/responses/size_food_response.dart';

class SizeFoodRepository{
  String foodId;
  SizeFoodApiProvider _apiProvider;

  Future<SizeFoodResponse> getSizeFoodList() async{
    _apiProvider = SizeFoodApiProvider(foodId);
    return _apiProvider.getSizeFoodList();
  }
}