import 'package:cafe_app/responses/size_food_response.dart';
import 'package:cafe_app/widgets/utils/handle_error.dart';
import 'package:cafe_app/widgets/utils/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:cafe_app/configurations/app_cafe_server.dart';

class SizeFoodApiProvider{
  String _endpoint = SERVER_URL_DEFAULT + API_SIZE_FOOD +"?id=";
  String foodId;
  Dio _dio;

  SizeFoodApiProvider(String foodId){
    BaseOptions options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    this.foodId = foodId;
  }
  Future<SizeFoodResponse> getSizeFoodList() async{
    try{
      setupInterceptor(_dio);
      print(foodId);
      Response response;
      print(_endpoint + foodId);
      response = await _dio.get(_endpoint+foodId);
      return SizeFoodResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return SizeFoodResponse.withError(handleError(error));
    }
  }
}