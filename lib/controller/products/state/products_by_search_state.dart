import 'package:saxonmarket/models/product_model.dart';

abstract class ProductsBySearchState {
  const ProductsBySearchState();
}

class ProductsBySearchInitialState extends ProductsBySearchState {
  const ProductsBySearchInitialState();
}

class ProductsBySearchLoadingState extends ProductsBySearchState {
  const ProductsBySearchLoadingState();
}

class ProductsBySearchSuccessState extends ProductsBySearchState {
  final List<ProductModel> productsBySearch;
  const ProductsBySearchSuccessState(this.productsBySearch);
}

class ProductsBySearchErrorState extends ProductsBySearchState {
  const ProductsBySearchErrorState();
}
