import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/products/state/products_by_category_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/controller/pagination/products/products_by_category_scroll_provider.dart';
import 'package:saxonmarket/network/network_utils.dart';

final productsByCategoryProvider = StateNotifierProvider<ProductsByCategoryController, ProductsByCategoryState>(
  (ref) => ProductsByCategoryController(ref: ref),
);

class ProductsByCategoryController extends StateNotifier<ProductsByCategoryState> {
  final Ref? ref;
  ProductsByCategoryController({this.ref}) : super(ProductsByCategoryInitialState());

  List<ProductModel>? productsByCategory = [];
  int currentPage = 1;
  int? totalPage;

  Future fetchProductsByCategory(int categoryId) async {
    state = ProductsByCategoryLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getProducts(categoryId: categoryId)),
      );
      if (responseBody != null) {
        productsByCategory = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
        totalPage = responseBody['total_page'];
        currentPage=1;
        print('totalPage: '+totalPage.toString()+'currentPage: '+currentPage.toString());
        state = ProductsByCategorySuccessState(productsByCategory!);
      } else {
        state = ProductsByCategoryErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = ProductsByCategoryErrorState();
    }
  }



   Future fetchMoreProductsByCategory(int categoryId) async {
    var responseBody;
    if (totalPage != null && (currentPage < totalPage!))
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.getProducts(categoryId: categoryId, pageNumber: currentPage += 1)),
        );
        if (responseBody != null) {
          var moreProductsByCategory = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
          currentPage=responseBody['current_page'];
          state = ProductsByCategorySuccessState(productsByCategory!..addAll(moreProductsByCategory));
          
          ref!.read(productsByCategoryScrollProvider.notifier).resetState();
        } else {
          state = ProductsByCategoryErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = ProductsByCategoryErrorState();
      }
    else
      ref!.read(productsByCategoryScrollProvider.notifier).resetState();
   
  }
}

