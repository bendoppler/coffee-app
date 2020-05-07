import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/repositories/category_food_repository.dart';
import 'package:cafe_app/responses/category_food_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:collection';
import 'package:tuple/tuple.dart';

class CategoryFoodBloc implements BlocBase{
  CategoryFoodRepository _categoryFoodRepository = CategoryFoodRepository() ;
  final int initialIndex;
  final int lengthTab;
  final List<Tuple2<String, String>> ids;
  var _foodsList = <CategoryFoodResponse>[];

  //behaviour subject
  final BehaviorSubject<String> _initialTabSubject =  BehaviorSubject<String>();
  final BehaviorSubject<UnmodifiableListView<Tab>> _tabsSubject = BehaviorSubject<UnmodifiableListView<Tab>>();
  final BehaviorSubject<UnmodifiableListView<CategoryFoodResponse>> _foodsListSubject = BehaviorSubject<UnmodifiableListView<CategoryFoodResponse>>();
  final BehaviorSubject<CategoryFoodResponse> _foodListSubject = BehaviorSubject<CategoryFoodResponse>();
  final BehaviorSubject<int> _selectedIndexSubject = BehaviorSubject<int>();

  //stream
  Stream<UnmodifiableListView<CategoryFoodResponse>> get foodLists => _foodsListSubject.stream;
  Stream<CategoryFoodResponse> get foodList => _foodListSubject.stream;

  //sink
  Sink<int> get selectedIndexSink => _selectedIndexSubject.sink;

  //value
  int get selectedIndex => _selectedIndexSubject.stream.value;
  CategoryFoodBloc(this.ids, this.initialIndex, this.lengthTab){
    _updateFoodLists().then((_){
      _foodsListSubject.sink.add(UnmodifiableListView(_foodsList));
    });
  _selectedIndexSubject.sink.add(initialIndex);
    _categoryFoodRepository.id = ids[initialIndex].item1;
    _getFoodListBasedOnCategory().then((categoryResponse){
      _foodListSubject.sink.add(categoryResponse);
    });
  }

  Future<CategoryFoodResponse> _getFoodListBasedOnCategory() async{
    CategoryFoodResponse response = await _categoryFoodRepository.getFoodListBasedOnCategory();
    return response;
  }

  Future<dynamic> _updateFoodLists() async{
    final futureFoods = ids.map((id){
      print("category id: " + id.item1);
      if(id.item1!= null && id.item1 != ''){
        _categoryFoodRepository.id = id.item1;
        return _getFoodListBasedOnCategory();
      }
    });
    final foods =await Future.wait(futureFoods);
    print("foodList: " + futureFoods.toString());
    print("foodList: " + foods.toString());
    _foodsList = foods;
    print("foodsList: " + _foodsList.length.toString());
  }

  Future<dynamic> updateFoodList() async{
    _categoryFoodRepository.id = ids[selectedIndex].item1;
    await _getFoodListBasedOnCategory().then((categoryResponse){
      _foodListSubject.sink.add(categoryResponse);
    });
  }
  @override
  void dispose() {
    _foodListSubject.close();
    _foodsListSubject.close();
    _initialTabSubject.close();
    _selectedIndexSubject.close();
    _tabsSubject.close();
  }
}