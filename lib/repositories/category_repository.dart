
import 'package:cafe_app/api_providers/category_provider.dart';
import 'package:cafe_app/responses/category_response.dart';

class CategoryRepository{
  final CategoryApiProvider _categoryApiProvider = CategoryApiProvider();

  Future<CategoryResponse> getCategoryList(){
    return _categoryApiProvider.getCategoryList();
  }
}