import 'dart:collection';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/models/food.dart';
import 'package:cafe_app/models/order.dart';
import 'package:cafe_app/models/size_food.dart';
import 'package:cafe_app/repositories/order_repository.dart';
import 'package:cafe_app/repositories/size_food_repository.dart';
import 'package:cafe_app/requests/order_request.dart';
import 'package:cafe_app/responses/size_food_response.dart';
import 'package:cafe_app/widgets/utils/currency.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc implements BlocBase{
  //repository
  final OrderRepository _repository = OrderRepository();
  SizeFoodRepository _sizeFoodRepository = SizeFoodRepository();
  //stream controller
  final BehaviorSubject<String> _addressSubject = new BehaviorSubject<String>();
  //final BehaviorSubject<List<Food>> _foodListSubject = new BehaviorSubject();
  final BehaviorSubject<Food> _newFoodSubject = new BehaviorSubject();
  final BehaviorSubject<Order> _orderSubject = new BehaviorSubject();
  final BehaviorSubject<String> _billSubject = new BehaviorSubject();
  final BehaviorSubject<int> _radioSubject = new BehaviorSubject();
  final BehaviorSubject<bool> _optionalSubject = new BehaviorSubject();
  final BehaviorSubject<String> _idSubject = new BehaviorSubject();
  final BehaviorSubject<int> _mainFoodSubject = new BehaviorSubject();
  final BehaviorSubject<int> _toppingSubject = new BehaviorSubject();
  final BehaviorSubject<int> _numberOfFoodSubject = new BehaviorSubject();
  final BehaviorSubject<HashMap<String, int>> _numberOfFoodMapSubject = new BehaviorSubject();
  final _orderRequestSubject = new BehaviorSubject<OrderRequest>();
  final _foodListSubject = new BehaviorSubject<SizeFoodResponse>();
  //data
  Order _order = new Order();
  HashMap<String,Food> _foodMap = new HashMap();
  String id;
  HashMap<String, int> _numberOfFoodMap = new HashMap();
  Food _food = new Food();

  //stream
  Stream<Food> get foodStream => _newFoodSubject.stream;
  Stream<String> get billStream => _billSubject.stream;
  Stream<int> get radioStream => _radioSubject.stream;
  Stream<bool> get optionalStream => _optionalSubject.stream;
  Stream<int> get numberOfFoodStream => _numberOfFoodSubject.stream;
  Stream<Order> get orderStream => _orderSubject.stream;
  Stream<HashMap<String, int>> get numberOfFoodMapStream => _numberOfFoodMapSubject.stream;
  Stream<OrderRequest> get orderRequestStream => _orderRequestSubject.stream;
  Stream<SizeFoodResponse> get sizeFoodListStream => _foodListSubject.stream;
  //sink
  Sink<String> get idSink =>_idSubject.sink;
  Sink<Food> get foodSink =>_newFoodSubject.sink;
  Sink<String> get billSink => _billSubject.sink;
  Sink<int> get numberOfFoodSink => _numberOfFoodSubject.sink;
  Food get food => _newFoodSubject.stream.value;
  Food get foodInfo => _food;


  /*ADDRESS*/
  BehaviorSubject<LatLng> _userLocationSubject = new BehaviorSubject();
  BehaviorSubject<Marker> _markerSubject = new BehaviorSubject();
  //stream
  Stream<LatLng> get userLocationStream => _userLocationSubject.stream;
  //sink
  Sink<LatLng> get userLocationSink => _userLocationSubject.sink;
  //data
  Marker _marker ;

  OrderBloc(){
    _orderSubject.add(_order);
  }
  void addAddress(String address, double lat, double long){
    _order.latitude = lat;
    _order.longitude = long;
    _order.address = address;
    _orderSubject.add(_order);
    print('address: ' + _orderSubject.value.address);
  }
  void addMarker(Marker _selectedMarker){
    _marker = _selectedMarker;

    addAddress(_marker.infoWindow.title, _marker.position.latitude, _marker.position.longitude);
  }
  Marker getMarker(){
    if(_marker != null)
      print('marker: '+ _marker.infoWindow.title);
    return _marker;
  }
  void addFoodToScreen(Food food, String id){
    _food = food;
    _sizeFoodRepository.foodId = id;
    _sizeFoodRepository.getSizeFoodList().then((response){
      _foodListSubject.add(response);
    });
    this.id = id;
    _idSubject.add(id);
    if(_foodMap.containsKey(id)){
      print('already have');
    }else{
      _food.price = food.price;
      _food.size = 0;
      _food.quantity = 1;
      _food.topping = 0;
      _foodMap[id] = _food;
    }
    if(_foodMap[id].quantity == 0){
      _foodMap[id].quantity=1;
    }
    _mainFoodSubject.add(_foodMap[id].price);
    _radioSubject.add(_foodMap[id].size);
    _numberOfFoodSubject.add(_foodMap[id].quantity);
    _numberOfFoodMap[id] = _foodMap[id].quantity;
    _numberOfFoodMapSubject.add(_numberOfFoodMap);
    _toppingSubject.add(_foodMap[id].topping);
    _newFoodSubject.add(_foodMap[id]);
    if(_foodMap[id].topping == 0){
      _optionalSubject.add(false);
    }else{
      _optionalSubject.add(true);
    }
    handleBillString();
  }
  void addFoodToOrder() {
    _foodMap[id].price = _foodListSubject.value.foodList[_radioSubject.value].price;
    _foodMap[id].size = _radioSubject.value;
    _foodMap[id].quantity =_numberOfFoodMapSubject.value[id];
    _foodMap[id].topping = _toppingSubject.stream.value;
    _calculatePrice();
    _order.foodMap.addAll(_foodMap);
    _orderSubject.add(_order);
  }
  void addQuantityToFood(int quantity){
    int result = _numberOfFoodMapSubject.value[_idSubject.value] + quantity;
    if(result>=0) {
      _numberOfFoodSubject.add(result);
      _numberOfFoodMap[_idSubject.value] = result;
      _numberOfFoodMapSubject.add(_numberOfFoodMap);
    }
  }
  void handleBillString(){
    int bill = (_mainFoodSubject.stream.value + _toppingSubject.stream.value)*_numberOfFoodMapSubject.stream.value[id] ;
    if (bill>0){
      _billSubject.add(convertIntToString(bill) + ' vnđ');
    }else{
      _billSubject.add("BỎ CHỌN MÓN");
    }
  }
  void handleSizeValueChange(int value) {
    _radioSubject.sink.add(value);
    switch(value){
      case 0:
        _mainFoodSubject.add(_foodListSubject.stream.value.foodList[0].price);
        break;
      case 1:
        _mainFoodSubject.add(_foodListSubject.stream.value.foodList[1].price);
        break;
      case 2:
        _mainFoodSubject.add(_foodListSubject.stream.value.foodList[2].price);
        break;
    }
    handleBillString();
  }
  void handleOptionalValueChange(bool value){
    _optionalSubject.sink.add(value);
    if(value == false){
      _toppingSubject.add(0);
    }else{
      _toppingSubject.add(10000);
    }
    handleBillString();
  }
  postOrder() async{
    OrderRequest request = await _repository.postOrder(_orderSubject.value.toJson());
    _orderRequestSubject.add(request);
    print('request: ' + _orderSubject.value.toString());
    //dispose();
  }
  deleteOrder(){
    _order = new Order();
    _orderSubject.add(_order);
    _orderRequestSubject.add(null);
    _foodMap.clear();
    _numberOfFoodMap.clear();
  }
  @override
  void dispose() {
    _addressSubject.close();
    _foodListSubject.close();
    _newFoodSubject.close();
    _orderSubject.close();
    _billSubject.close();
    _radioSubject.close();
    _optionalSubject.close();
    _mainFoodSubject.close();
    _toppingSubject.close();
    _numberOfFoodSubject.close();
    _numberOfFoodMapSubject.close();
    _idSubject.close();
    _userLocationSubject.close();
    _markerSubject.close();
    _orderRequestSubject.close();
  }
  void _calculatePrice() {
    _order.price = 0;
    _foodMap.forEach((id,food){
      _order.price += (food.price + food.topping)*food.quantity;
    });
    print("price: "+_order.price.toString());
  }
}

