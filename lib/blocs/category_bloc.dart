
import 'dart:async';

import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/models/food.dart';
import 'package:cafe_app/repositories/category_repository.dart';
import 'package:cafe_app/responses/category_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'dart:collection';

class CategoryBloc implements BlocBase{
  //repository
  final CategoryRepository _categoryRepository = CategoryRepository();
  //subject
  final BehaviorSubject<CategoryResponse> _categorySubject = BehaviorSubject<CategoryResponse>();
  final BehaviorSubject<int> _initialIndexController = BehaviorSubject<int>();
  final BehaviorSubject<UnmodifiableListView<Tuple2<String,String>>> _categoryListIdSubject = BehaviorSubject<UnmodifiableListView<Tuple2<String,String>>>();

  //stream
  Stream<CategoryResponse> get categories => _categorySubject.stream;
  //data
  int get lengthTab => _categoryListIdSubject.value.length;
  int get defaultInitialIndex => 0;
  int get initialIndex => _initialIndexController.stream.value;
  UnmodifiableListView<Tuple2<String,String>> get categoryIds => _categoryListIdSubject.stream.value;
  //sink
  Sink<int> get initialIndexSink => _initialIndexController.sink;
  Sink<int> get tabBarLengthSink => _initialIndexController.sink;
  CategoryBloc() {
    getCategoryList().then((_){
      _categoryListIdSubject.sink.
      add(UnmodifiableListView(_categorySubject.stream.value.categories
        .map((category){
          return Tuple2(category.id, category.title);
        }).toList()));
    });
  }

  getCategoryList() async{
    CategoryResponse response = await _categoryRepository.getCategoryList();
    _categorySubject.sink.add(response);
  }

  @override
  void dispose() {
    _categorySubject.close();
    _categoryListIdSubject.close();
    _initialIndexController.close();
  }
}