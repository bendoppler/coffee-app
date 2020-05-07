import 'package:cafe_app/responses/category_food_response.dart';
import 'package:cafe_app/widgets/utils/handle_error.dart';
import 'package:cafe_app/widgets/utils/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:cafe_app/configurations/app_cafe_server.dart';

class CategoryFoodApiProvider{
  String _endpoint = SERVER_URL_DEFAULT + API_FOOD +"?category=";
  final String categoryId;
  Dio _dio;

  CategoryFoodApiProvider(this.categoryId){
    BaseOptions options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
  }
  Future<CategoryFoodResponse> getFoodListBasedOnCategory() async{
    try{
      setupInterceptor(_dio);
      print(categoryId);
      Response response;
      response = await _dio.get(_endpoint+ categoryId);
      return CategoryFoodResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return CategoryFoodResponse.withError(handleError(error));
    }
  }
}