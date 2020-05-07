import 'package:cafe_app/api_providers/order_provider.dart';
import 'package:cafe_app/requests/order_request.dart';

class OrderRepository{
  final OrderApiProvider _apiProvider = OrderApiProvider();

  Future<OrderRequest> postOrder(order){
    return _apiProvider.postOrder(order);
  }
}