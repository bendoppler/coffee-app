import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/blocs/category_food_bloc.dart';
import 'package:cafe_app/blocs/order_bloc.dart';
import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/models/food.dart';
import 'package:cafe_app/models/order.dart';
import 'package:cafe_app/pages/food_item_details.dart';
import 'package:cafe_app/pages/map_page.dart';
import 'package:cafe_app/responses/category_food_response.dart';
import 'package:cafe_app/pages/shopping_cart_page.dart';
import 'package:cafe_app/widgets/utils/color.dart';
import 'package:cafe_app/widgets/utils/currency.dart';
import 'package:cafe_app/widgets/utils/error.dart';
import 'package:cafe_app/widgets/utils/loading.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class CategoryFoodItems extends StatefulWidget{
  final OrderBloc orderBloc;
  CategoryFoodItems(this.orderBloc);
  @override
  _CategoryFoodItemsState createState() => _CategoryFoodItemsState();
}

class _CategoryFoodItemsState extends State<CategoryFoodItems> with TickerProviderStateMixin{
  Widget _backArrowIcon(BuildContext _context) => new IconButton(
    icon: Icon(
      Icons.arrow_back_ios,
      size: 28.0,
      color: Color(0xff303030)
    ),
    onPressed: () {
      Navigator.of(_context).pop();
    });

  Widget _searchLocationTextField(BuildContext _context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: TextField(
          maxLines: 1,
          enabled: false,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(_context).brightness == Brightness.light
              ? Color(0xff303030)
              : Colors.grey[200],
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme
              .of(_context)
              .brightness == Brightness.light
              ? Colors.white
              : Color(0xFF303030),
            hintText: AppLocalizations
              .of(_context)
              .address,
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(_context).brightness == Brightness.light
                ? Color(0xff303030)
                : Colors.grey[200],
            ),
            prefixIcon: Icon(
              Icons.location_on,
              color: Theme
                .of(_context)
                .brightness == Brightness.light
                ? Color(0xff303030)
                : Colors.grey[200],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            contentPadding: EdgeInsets.zero),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MapScreen(orderBloc: widget.orderBloc)));
        }
      ),
    );
  }

  final Widget _historyIcon = new IconButton(
    icon: Icon(
      Icons.history,
      size: 32.0,
      color: Color(0xff000000),
    ),
    onPressed: () {
      //TODO: show history search list
    },
    iconSize: 24,
    color: Colors.black87,
  );

  Widget _searchFoodItemTextField(BuildContext context) => InkWell(
    child: TextField(
      enabled: false,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
          ? Color(0xFF424242)
          : Colors.grey[200],
      ),
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).food,
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.light
            ? Color(0xff303030)
            : Colors.grey[200]
        ),
        filled: true,
        fillColor: Theme
          .of(context)
          .brightness == Brightness.light
          ? Colors.white
          : Color(0xFF303030),
        suffixIcon: Icon(
          Icons.search,
          color: Theme.of(context).brightness == Brightness.light
            ? Color(0xff303030)
            : Colors.grey[200],
          size: 32.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      onTap: () {
        //TODO: enter text to search food Item
      },
    ),
  );
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _categoryFoodBloc = BlocProvider.of<CategoryFoodBloc>(context);
    final _tabController = TabController(
      length: _categoryFoodBloc.lengthTab,
      initialIndex: _categoryFoodBloc.selectedIndex,
      vsync: this
    );
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ?  Colors.white : Color(0xff303030),
      body: Column(
        children: <Widget>[
          Container(
            height: _size.height * 0.23,
            decoration: BoxDecoration(
              color: Color(0xffffce50)
            ),
            padding: EdgeInsets.only(top: 22.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _backArrowIcon(context),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                        child: _searchLocationTextField(context),
                      ),
                    ),
                    _historyIcon
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 25, right: 25),
                    child: _searchFoodItemTextField(context),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            color: Theme.of(context).brightness == Brightness.light ?  Colors.white : Color(0xff303030),
            child: TabBar(
              controller: _tabController,
              tabs: List<Widget>.generate(_categoryFoodBloc.lengthTab,(int index){
                return Tab(
                  child: Text(
                  _categoryFoodBloc.ids[index].item2,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: getColor1(context)
                    ),
                  ),
                );
              }
              ),
              indicatorColor: Color(0xFFFFC700),
              labelColor: Color(0xFFFFC700),
              unselectedLabelColor: Color(0xFF8F8F8F),
              labelStyle: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13.0,
                fontWeight: FontWeight.normal,
                color: Color(0xff303030)
              ),
              onTap: (index){
                _categoryFoodBloc.selectedIndexSink.add(index);
                _categoryFoodBloc.updateFoodList();
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                StreamBuilder<CategoryFoodResponse>(
                  stream: _categoryFoodBloc.foodList,
                  builder: (context, snapshot) {
                    return TabBarView(
                      controller: _tabController,
                      children: List<Widget>.generate(_categoryFoodBloc.lengthTab, (int index){
                        print("index: " + index.toString());
                        if(_categoryFoodBloc.selectedIndex != index){
                          return Container();
                        }else{
                          if (snapshot.hasData) {
                            if (snapshot.data.error != null && snapshot.data.error.length > 0){
                              return buildErrorWidget(snapshot.data.error, context);
                            }
                            return _buildFoodList( context, UnmodifiableListView(snapshot.data.foods));

                          } else if (snapshot.hasError) {
                            return buildErrorWidget(snapshot.error, context);
                          } else {
                            return buildLoadingWidget(context);
                          }
                        }
                      }),
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: StreamBuilder<Order>(
                      stream: widget.orderBloc.orderStream,
                      builder: (context, snapshot) {
                        if(snapshot.data!=null && snapshot.data.price > 0){
                          return ButtonTheme(
                            height: _size.height * 0.055,
                            minWidth: _size.width * 0.9,
                            child: RaisedButton(
                              onPressed: (){
                                Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (BuildContext context){
                                    return ShoppingCartScreen(widget.orderBloc);
                                }));
                              },
                              color: Color(0xffffce50),
                              child: Text(
                                'XEM GIỎ HÀNG (' + convertIntToString(snapshot.data.price) +
                                  ' VND)',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          );
                        }else{
                          return Container(
                            width: 0.0,
                            height: 0.0,
                          );
                        }
                      }
                    )
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildFoodList(BuildContext context, UnmodifiableListView<Food> foods) {

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i >= foods.length) {
          //TODO: get more food from category or end of list
        } else {
          return _buildCard(foods[i], context);
        }
      },
    );
  }

  Widget _buildCard(Food food, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey[200]
          ),
          borderRadius: BorderRadius.circular(8.0)
        ),
        color: getColor(context),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              width: 150,
              height: 150,
              child: Image.network(food.image, fit: BoxFit.fill),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 27.0, bottom: 4.0),
                      child: Text(
                        food.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xFF424242)
                            : Colors.grey[200],
                          fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        food.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xFF424242)
                            : Colors.grey[200],
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 19.0),
                      child: Text(
                        convertIntToString(food.price) + ' vnđ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffffce50),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal),
                      )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 26.0),
                      child: RaisedButton(
                        color: getColor(context),
                        child: Text(AppLocalizations.of(context).pick),
                        onPressed: (){
                          widget.orderBloc.addFoodToScreen(food, food.id);
                          _openIdemDetailsScreen(context);
                        },
                    ),
                  ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
  void _openIdemDetailsScreen(BuildContext context) {
    Navigator
      .of(context)
      .push(MaterialPageRoute(builder: (BuildContext context){
      return ItemDetailsScreen(widget.orderBloc);
    }));
  }
}
