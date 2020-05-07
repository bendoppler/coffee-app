
import 'package:cafe_app/blocs/application_bloc.dart';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/lang/localizations.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  CustomBottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return StreamBuilder<NavigationBarItem>(
      initialData: _applicationBloc.defaultItem,
      stream: _applicationBloc.itemStream,
      builder: (context, _snapshot) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _snapshot.data.index,//change when click
          onTap: _applicationBloc.pickItem,
          items: [
            BottomNavigationBarItem(
              icon: StreamBuilder<Color>(
                initialData: Colors.amber,
                stream: _applicationBloc.homeBarItemColor,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Image.asset('assets/icons/icon_home.png',
                      height: 24.0,
                      color: snapshot.data,
                    )
                    );
                }
              ),
                title: StreamBuilder<Color>(
                  initialData: Colors.amber,
                  stream: _applicationBloc.homeBarItemColor,
                  builder: (context, snapshot) {
                    return Text(
                      AppLocalizations.of(context).homePage,
                      style: TextStyle(
                        color: snapshot.data
                      ),
                    );
                  }
                ),
            ),
            BottomNavigationBarItem(
              icon: StreamBuilder<Color>(
                initialData: _applicationBloc.initialColor(),
                stream: _applicationBloc.orderBarItemColor,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Image.asset('assets/icons/icon_shopping.png',
                      height: 24.0,
                      color: snapshot.data,
                    )
                  );
                }
              ),
              title: StreamBuilder<Color>(
                initialData: _applicationBloc.initialColor(),
                stream: _applicationBloc.orderBarItemColor,
                builder: (context, snapshot) {
                  return Text(
                    AppLocalizations.of(context).order,
                    style: TextStyle(
                      color: snapshot.data
                    ),
                  );
                }
              ),
            ),
            BottomNavigationBarItem(
              icon: StreamBuilder<Color>(
                initialData: _applicationBloc.initialColor(),
                stream: _applicationBloc.yamaBarItemColor,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Image.asset('assets/icons/icon_yama.png',
                      height: 24.0,
                      color: snapshot.data,
                    )
                  );
                }
              ),
              title: StreamBuilder<Color>(
                initialData: _applicationBloc.initialColor(),
                stream: _applicationBloc.yamaBarItemColor,
                builder: (context, snapshot) {
                  return Text(
                    AppLocalizations.of(context).appSymbol,
                    style: TextStyle(
                      color: snapshot.data
                    ),
                  );
                }
              ),
            ),
            BottomNavigationBarItem(
              icon: StreamBuilder<Color>(
                initialData: _applicationBloc.initialColor(),
                stream: _applicationBloc.userBarItemColor,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Image.asset('assets/icons/icon_user.png',
                      height: 24.0,
                      color: snapshot.data,
                    )
                  );
                }
              ),
              title: StreamBuilder<Object>(
                initialData: _applicationBloc.initialColor(),
                stream: _applicationBloc.userBarItemColor,
                builder: (context, snapshot) {
                  return Text(
                    AppLocalizations.of(context).user,
                    style: TextStyle(
                      color: snapshot.data
                    ),
                  );
                }
              ),
            ),
          ],
        );
      }
    );
  }
}