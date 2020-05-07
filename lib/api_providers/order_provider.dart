import 'package:cafe_app/configurations/app_cafe_server.dart';
import 'package:cafe_app/requests/order_request.dart';
import 'package:cafe_app/widgets/utils/interceptor.dart';
import 'package:dio/dio.dart';

class OrderApiProvider{
  final String _endpoint = SERVER_URL_DEFAULT + API_ORDER;
  Dio _dio;

  OrderApiProvider(){
    BaseOptions options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    setupInterceptor(_dio);
  }

  Future<OrderRequest> postOrder(order) async{
    try{
      print('category provider');
      Response response = await _dio.post(_endpoint,data: order);
      return OrderRequest.withResult(response.statusCode.toString());
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return OrderRequest.withResult(error.toString());
    }
  }
}