import 'package:saxonmarket/models/category_model.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInitialState extends CategoryState {
  const CategoryInitialState();
}

class CategoryLoadingState extends CategoryState {
  const CategoryLoadingState();
}

class CategorySuccessState extends CategoryState {
  final List<CategoryModel> categoryModel;
  const CategorySuccessState(this.categoryModel);
}

class CategoryErrorState extends CategoryState {
  const CategoryErrorState();
}
