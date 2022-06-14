import 'package:saxonmarket/models/product_details_model.dart';

abstract class ProductDetailsState {
  const ProductDetailsState();
}

class ProductDetailsInitialState extends ProductDetailsState {
  const ProductDetailsInitialState();
}

class ProductDetailsLoadingState extends ProductDetailsState {
  const ProductDetailsLoadingState();
}

class ProductDetailsSuccessState extends ProductDetailsState {
  final ProductDetailsModel productModel;
  const ProductDetailsSuccessState(this.productModel);
}

class ProductDetailsErrorState extends ProductDetailsState {
  const ProductDetailsErrorState();
}
