import 'package:cafe_app/blocs/application_bloc.dart';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/screens/main_screen.dart';
import 'package:cafe_app/screens/order_screen.dart';
import 'package:cafe_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  return runApp(
    BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return StreamBuilder<ThemeData>(
      initialData: _applicationBloc
        .initialTheme()
        .data,
      stream: _applicationBloc.theme,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          title: 'Cafe App',
          locale: Locale('vi'),
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          theme: snapshot.data,
          home: MyHomePage()
        );
      },
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Alignment>(
          initialData: Alignment.centerLeft,
          stream: _applicationBloc.alignment,
          builder: (context, snapshot) {
            return Align(
              alignment: snapshot.data,
              child: StreamBuilder<String>(
                initialData: _applicationBloc.defaultTitle,
                stream: _applicationBloc.title,
                builder: (context, snapshot){
                  return Text(
                    snapshot.data,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff303030)
                    ),
                  );
                },
              ),
            );
          }
        ),
        elevation: 0.0,
      ),
      body: StreamBuilder<NavigationBarItem>(
        initialData: _applicationBloc.defaultItem,
        stream: _applicationBloc.itemStream,
        builder: (context, snapshot){
          switch(snapshot.data){
            case NavigationBarItem.HOME:
              return MainScreen();
              break;
            case NavigationBarItem.ORDER:
              return OrderScreen();
              break;
            default:
              return Container();
              break;
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
