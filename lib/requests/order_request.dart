

class OrderRequest{
  static final OrderRequest _orderRequest = new OrderRequest._internal();
  String result;

  factory OrderRequest(){
    return _orderRequest;
  }
  OrderRequest.withResult(String result)
    : this.result = result;
  OrderRequest._internal();
}