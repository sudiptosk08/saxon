import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/products/state/product_details_state.dart';
import 'package:saxonmarket/models/product_details_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final productDetailsProvider = StateNotifierProvider<ProductDetailsController, ProductDetailsState>(
  (ref) => ProductDetailsController(ref: ref),
);

class ProductDetailsController extends StateNotifier<ProductDetailsState> {
  final Ref? ref;
  ProductDetailsController({this.ref}) : super(ProductDetailsInitialState());

  ProductDetailsModel? productDetailsModel;

  Future fetchProductDetails(int productId) async {
    state = ProductDetailsLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getProductDetails(productId)),
      );
      if (responseBody != null) {
        productDetailsModel = ProductDetailsModel.fromJson(responseBody);

        state = ProductDetailsSuccessState(productDetailsModel!);
      } else {
        state = ProductDetailsErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = ProductDetailsErrorState();
    }
  }
}
