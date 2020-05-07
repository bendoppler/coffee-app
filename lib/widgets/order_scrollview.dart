import 'dart:collection';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/blocs/category_bloc.dart';
import 'package:cafe_app/blocs/category_food_bloc.dart';
import 'package:cafe_app/blocs/order_bloc.dart';
import 'package:cafe_app/models/category.dart';
import 'package:cafe_app/pages/category_food_items.dart';
import 'package:cafe_app/responses/category_response.dart';
import 'package:cafe_app/widgets/utils/color.dart';
import 'package:cafe_app/widgets/utils/error.dart';
import 'package:cafe_app/widgets/utils/loading.dart';
import 'package:flutter/material.dart';



class OrderScrollview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    return SingleChildScrollView(
      child: StreamBuilder<CategoryResponse>(
        stream: _categoryBloc.categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0){
              return buildErrorWidget(snapshot.data.error, context);
            }
            return buildOrderMenuUI(UnmodifiableListView(snapshot.data.categories), context);

          } else if (snapshot.hasError) {
            return buildErrorWidget(snapshot.error, context);
          } else {
            return buildLoadingWidget(context);
          }
        }
      ),
    );
  }

  Widget buildOrderMenuUI(UnmodifiableListView<Category> _categoryList, BuildContext context) =>
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: buildCategoryUI(_categoryList, context),
      ),
    );

  List<Widget> buildCategoryUI(UnmodifiableListView<Category> categories, BuildContext context) {
    //final _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    var categoryCardsList = new List<Widget>();
    var currentRow = new List<Widget>();

    for (int i = 0; i < categories.length; i++) {
      currentRow.add(buildCategoryCard(categories[i].title, i, context));
      // Last one and is odd
      if (i % 2 == 0 && i == categories.length - 1) {
        currentRow.add(Expanded(child: Container()));
        categoryCardsList.add(Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(children: currentRow,),
        ));
      } else if (i % 2 == 1) {
        categoryCardsList.add(Padding(
          padding: EdgeInsets.only(top: (i / 2) >= 1 ? 12.0 : 0.0),
          child: Row(
            children: currentRow,
          ),
        ));
        currentRow = new List<Widget>();
      }
    }
    return categoryCardsList;
  }

  Widget buildCategoryCard(String name, int index, BuildContext context) {
    print("index: "+ index.toString());
    return Expanded(
      child: Padding(
        padding: index % 2 == 0
          ? const EdgeInsets.only(right: 6.0)
          : const EdgeInsets.only(left: 6.0),
        child: RaisedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 42.0),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: getColor1(context)
              ),
            ),
          ),
          color: Theme
            .of(context)
            .brightness == Brightness.light
            ? Colors.grey[500]
            : Color(0xFF424242),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          onPressed: () {
            _openFoodListBasedOnCategories(context, index);
          },
        ),
      ),
    );
  }

  void _openFoodListBasedOnCategories(BuildContext context, int index) {
    final _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    final _orderBloc = BlocProvider.of<OrderBloc>(context);
    _categoryBloc.initialIndexSink.add(index);
    final _categoryFoodBloc = CategoryFoodBloc(_categoryBloc.categoryIds, _categoryBloc.initialIndex, _categoryBloc.lengthTab);
    Navigator
      .of(context)
      .push(MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          bloc: _categoryFoodBloc,
          child: CategoryFoodItems(_orderBloc));
      }
    ));
  }
}