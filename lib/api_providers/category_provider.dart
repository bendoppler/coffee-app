import 'package:cafe_app/responses/category_response.dart';
import 'package:cafe_app/widgets/utils/handle_error.dart';
import 'package:cafe_app/widgets/utils/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:cafe_app/configurations/app_cafe_server.dart';
class CategoryApiProvider{
  final String _endpoint = SERVER_URL_DEFAULT + API_FOOD_CATEGORY;
  Dio _dio;

  CategoryApiProvider(){
    BaseOptions options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    setupInterceptor(_dio);
  }

  Future<CategoryResponse> getCategoryList() async{
    try{
      print('category provider');
      Response response = await _dio.get(_endpoint);
      return CategoryResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return CategoryResponse.withError(handleError(error));
    }
  }
}