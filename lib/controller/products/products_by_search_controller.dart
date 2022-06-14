import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/pagination/products/products_by_search_scroll_provider.dart';
import 'package:saxonmarket/controller/products/state/products_by_search_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final productsBySearchProvider = StateNotifierProvider<ProductsBySearchController, ProductsBySearchState>(
  (ref) => ProductsBySearchController(ref: ref),
);

class ProductsBySearchController extends StateNotifier<ProductsBySearchState> {
  final Ref? ref;
  ProductsBySearchController({this.ref}) : super(ProductsBySearchInitialState());

  List<ProductModel>? productsBySearch = [];
  int currentPage = 1;
  int? totalPage;

  Future fetchProductsBySearch(String str) async {
    state = ProductsBySearchLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getProducts(str: str)),
      );
      if (responseBody != null) {
        productsBySearch = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
        totalPage = responseBody['total_page'];
        state = ProductsBySearchSuccessState(productsBySearch!);
      } else {
        state = ProductsBySearchErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = ProductsBySearchErrorState();
    }
  }

  Future fetchMoreProductsBySearch(String str) async {
    var responseBody;
    if (totalPage != null && (currentPage < totalPage!))
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.getProducts(str: str, pageNumber: currentPage += 1)),
        );
        if (responseBody != null) {
          var moreProductsBySearch = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();

          state = ProductsBySearchSuccessState(productsBySearch!..addAll(moreProductsBySearch));
          ref!.read(productsBySearchScrollProvider.notifier).resetState();
        } else {
          state = ProductsBySearchErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = ProductsBySearchErrorState();
      }
    else
      ref!.read(productsBySearchScrollProvider.notifier).resetState();
  }
}
