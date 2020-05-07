import 'dart:async';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum ThemeStatus{light, dark, white}
enum NavigationBarItem {HOME, ORDER, YAMA, USER}

class ApplicationBloc implements BlocBase {


  final StreamController<NavigationBarItem> _navBarController = StreamController<NavigationBarItem>.broadcast();
  final _homeBarItemCtrl = PublishSubject<Color>();
  final _orderBarItemCtrl = PublishSubject<Color>();
  final _yamaBarItemCtrl = PublishSubject<Color>();
  final _userBarItemCtrl = PublishSubject<Color>();
  final _colorContainerCtrl = PublishSubject<Color>();
  final _titleCtrl = PublishSubject<String>();
  final _alignmentCtrl = PublishSubject<Alignment>();



  NavigationBarItem defaultItem = NavigationBarItem.HOME;
  String defaultTitle = "You Are My Angel";
  Stream<NavigationBarItem> get itemStream => _navBarController.stream;
  Sink<NavigationBarItem> get barItem => _navBarController.sink;
  Sink<ThemeData> get themeSink => themeSubject.sink;

  //control ui input output
  final themeSubject = new BehaviorSubject<ThemeData>();
  final themeStatusSubject = new BehaviorSubject<ThemeStatus>();
  //output to ui
  Stream<ThemeData> get theme => themeSubject.stream;
  Stream<ThemeStatus> get themeStatus => themeStatusSubject.stream;
  Stream<Color> get userBarItemColor => _userBarItemCtrl.stream;
  Stream<Color> get homeBarItemColor => _homeBarItemCtrl.stream;
  Stream<Color> get orderBarItemColor => _orderBarItemCtrl.stream;
  Stream<Color> get yamaBarItemColor => _yamaBarItemCtrl.stream;
  Stream<Color> get containerColor => _colorContainerCtrl.stream;
  Stream<String> get title => _titleCtrl.stream;
  Stream<Alignment> get alignment => _alignmentCtrl.stream;


  ApplicationBloc(){
    _titleCtrl.sink.add(defaultTitle);
    themeStatusSubject.sink.add(ThemeStatus.light);
    _alignmentCtrl.sink.add(Alignment.centerLeft);
    themeStatus.listen((onData){
      if(onData == ThemeStatus.light){
        themeSubject.sink.add(ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.amber,
        ));
        _colorContainerCtrl.sink.add(Colors.grey[100]);
      }
      else{
        themeSubject.sink.add(ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.amber,
        ));
        _colorContainerCtrl.sink.add(Color(0xff303030));
      }
    });
  }

  void pickItem(int i) {
    switch (i) {
      case 0:
        _alignmentCtrl.sink.add(Alignment.centerLeft);
        _titleCtrl.sink.add("You Are My Angel");
        _navBarController.sink.add(NavigationBarItem.HOME);
        _homeBarItemCtrl.sink.add(Colors.amber);
        themeStatus.listen((onData){
          if(onData == ThemeStatus.light){
            _orderBarItemCtrl.sink.add(Colors.black87);
            _yamaBarItemCtrl.sink.add(Colors.black87);
            _userBarItemCtrl.sink.add(Colors.black87);
          }
          else{
            _orderBarItemCtrl.sink.add(Colors.white70);
            _yamaBarItemCtrl.sink.add(Colors.white70);
            _userBarItemCtrl.sink.add(Colors.white70);
          }
        });
        break;
      case 1:
        _alignmentCtrl.sink.add(Alignment.center);
        _titleCtrl.sink.add("Đặt hàng online");
        _navBarController.sink.add(NavigationBarItem.ORDER);
        _orderBarItemCtrl.sink.add(Colors.amber);
        themeStatus.listen((onData){
          if(onData == ThemeStatus.light){
            _homeBarItemCtrl.sink.add(Colors.black87);
            _yamaBarItemCtrl.sink.add(Colors.black87);
            _userBarItemCtrl.sink.add(Colors.black87);
          }
          else{
            _homeBarItemCtrl.sink.add(Colors.white70);
            _yamaBarItemCtrl.sink.add(Colors.white70);
            _userBarItemCtrl.sink.add(Colors.white70);
          }
        });
        break;
      case 2:
        _navBarController.sink.add(NavigationBarItem.YAMA);
        _yamaBarItemCtrl.sink.add(Colors.amber);
        themeStatus.listen((onData){
          if(onData == ThemeStatus.light){
            _orderBarItemCtrl.sink.add(Colors.black87);
            _homeBarItemCtrl.sink.add(Colors.black87);
            _userBarItemCtrl.sink.add(Colors.black87);
          }
          else{
            _orderBarItemCtrl.sink.add(Colors.white70);
            _homeBarItemCtrl.sink.add(Colors.white70);
            _userBarItemCtrl.sink.add(Colors.white70);
          }
        });
        break;
      case 3:
        _navBarController.sink.add(NavigationBarItem.USER);
        _userBarItemCtrl.sink.add(Colors.amber);
        themeStatus.listen((onData){
          if(onData == ThemeStatus.light){
            _orderBarItemCtrl.sink.add(Colors.black87);
            _yamaBarItemCtrl.sink.add(Colors.black87);
            _homeBarItemCtrl.sink.add(Colors.black87);
          }
          else{
            _orderBarItemCtrl.sink.add(Colors.white70);
            _yamaBarItemCtrl.sink.add(Colors.white70);
            _homeBarItemCtrl.sink.add(Colors.white70);
          }
        });
        break;
    }
  }

  void dispose(){
    themeSubject.close();
    themeStatusSubject.close();
    _navBarController.close();
    _homeBarItemCtrl.close();
    _orderBarItemCtrl.close();
    _userBarItemCtrl.close();
    _yamaBarItemCtrl.close();
    _colorContainerCtrl.close();
    _titleCtrl.close();
    _alignmentCtrl.close();
  }
  DynamicTheme initialTheme() {
    return DynamicTheme(
      'light',
      ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.amber,
      ));
  }

  Color initialColor() {
    Color current = Colors.black;
    if(themeStatusSubject.value == ThemeStatus.dark){
      current = Colors.white70;
    }
    return current;
  }
}