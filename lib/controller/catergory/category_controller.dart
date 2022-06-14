import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/catergory/state/category_state.dart';
import 'package:saxonmarket/models/category_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final categoryProvider = StateNotifierProvider<CategoryController, CategoryState>(
  (ref) => CategoryController(ref: ref),
);

class CategoryController extends StateNotifier<CategoryState> {
  final Ref? ref;
  CategoryController({this.ref}) : super(CategoryInitialState());

  List<CategoryModel>? categoryModel = [];

  Future fetchCategories() async {
    state = CategoryLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getCategories(isTree: true)),
      );
      if (responseBody != null) {
        categoryModel = (responseBody as List<dynamic>).map((x) => CategoryModel.fromJson(x)).toList();

        state = CategorySuccessState(categoryModel!);
      } else {
        state = CategoryErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = CategoryErrorState();
    }
  }
}
