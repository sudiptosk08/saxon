import 'package:saxonmarket/models/product_model.dart';

abstract class ProductsByKeywordState {
  const ProductsByKeywordState();
}

class ProductsByKeywordInitialState extends ProductsByKeywordState {
  const ProductsByKeywordInitialState();
}

class ProductsByKeywordLoadingState extends ProductsByKeywordState {
  const ProductsByKeywordLoadingState();
}

class ProductsByKeywordSuccessState extends ProductsByKeywordState {
  final List<ProductModel> productsByKeyword;
  const ProductsByKeywordSuccessState(this.productsByKeyword);
}

class ProductsByKeywordErrorState extends ProductsByKeywordState {
  const ProductsByKeywordErrorState();
}
