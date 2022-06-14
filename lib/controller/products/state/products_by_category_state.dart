import 'package:saxonmarket/models/product_model.dart';

abstract class ProductsByCategoryState {
  const ProductsByCategoryState();
}

class ProductsByCategoryInitialState extends ProductsByCategoryState {
  const ProductsByCategoryInitialState();
}

class ProductsByCategoryLoadingState extends ProductsByCategoryState {
  const ProductsByCategoryLoadingState();
}

class ProductsByCategorySuccessState extends ProductsByCategoryState {
  final List<ProductModel> productsByCategory;
  const ProductsByCategorySuccessState(this.productsByCategory);
}

class ProductsByCategoryErrorState extends ProductsByCategoryState {
  const ProductsByCategoryErrorState();
}
