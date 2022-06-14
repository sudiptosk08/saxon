import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/pagination/products/products_by_keyword_scroll_provider.dart';
import 'package:saxonmarket/controller/products/state/products_by_keyword_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final productsByKeywordProvider = StateNotifierProvider<ProductsByKeywordController, ProductsByKeywordState>(
  (ref) => ProductsByKeywordController(ref: ref),
);

class ProductsByKeywordController extends StateNotifier<ProductsByKeywordState> {
  final Ref? ref;
  ProductsByKeywordController({this.ref}) : super(ProductsByKeywordInitialState());

  List<ProductModel>? newArrivalProducts = [];
  List<ProductModel>? bestSellerProducts = [];
  List<ProductModel>? productsByKeyword = [];
  int newArrivalCurrentPage = 1;
  int bestSellerCurrentPage = 1;
  int? newArrivalTotalPage;
  int? bestSellerTotalPage;

  Future fetchProductsByKeyword(String keyword) async {
    state = ProductsByKeywordLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getProducts(keyword: keyword)),
      );
      if (responseBody != null) {
        productsByKeyword = (responseBody as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
        state = ProductsByKeywordSuccessState(productsByKeyword!);
      } else {
        state = ProductsByKeywordErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = ProductsByKeywordErrorState();
    }
  }

  Future fetchNewArrivalProducts() async {
    state = ProductsByKeywordLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getProducts(keyword: 'new_arrivals')),
      );
      if (responseBody != null) {
        newArrivalProducts = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
        newArrivalTotalPage= responseBody['total_page'];
        newArrivalCurrentPage=1;
        state = ProductsByKeywordSuccessState(newArrivalProducts!);
      } else {
        state = ProductsByKeywordErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = ProductsByKeywordErrorState();
    }
  }

   Future fetchMoreNewArrivalProdcuts() async{
    var responseBody;
    if (newArrivalTotalPage != null && (newArrivalCurrentPage < newArrivalTotalPage!))
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.getProducts(keyword: 'new_arrivals', pageNumber: newArrivalCurrentPage += 1)),
        );
        if (responseBody != null) {
          var moreNewArrivalProducts = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
          newArrivalCurrentPage=responseBody['current_page'];
          newArrivalTotalPage= responseBody['total_page'];
          state = ProductsByKeywordSuccessState(newArrivalProducts!..addAll(moreNewArrivalProducts));
          
          ref!.read(productsByKeywordScrollProvider.notifier).resetState();
        } else {
          state = ProductsByKeywordErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = ProductsByKeywordErrorState();
      }
    else
      ref!.read(productsByKeywordScrollProvider.notifier).resetState();
   
  }

  Future fetchBestSellerProducts() async {
    state = ProductsByKeywordLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getProducts(keyword: 'trending_this_week')),
      );
      if (responseBody != null) {
        bestSellerProducts = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
        bestSellerTotalPage= responseBody['total_page'];
        bestSellerCurrentPage=1;
        state = ProductsByKeywordSuccessState(bestSellerProducts!);
      } else {
        state = ProductsByKeywordErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = ProductsByKeywordErrorState();
    }
  }


  Future fetchMoreBestSellerProducts() async{
    var responseBody;
     
    if (bestSellerTotalPage != null && (bestSellerCurrentPage < bestSellerTotalPage!))
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.getProducts(keyword: 'trending_this_week', pageNumber: bestSellerCurrentPage += 1)),
        );
        if (responseBody != null) {
          var moreBestSellerProducts = (responseBody['result'] as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();
          bestSellerCurrentPage=responseBody['current_page'];
          bestSellerTotalPage= responseBody['total_page'];
          state = ProductsByKeywordSuccessState(bestSellerProducts!..addAll(moreBestSellerProducts));
          
          ref!.read(productsByKeywordScrollProvider.notifier).resetState();
        } else {
          state = ProductsByKeywordErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = ProductsByKeywordErrorState();
      }
    else
      ref!.read(productsByKeywordScrollProvider.notifier).resetState();
   
  }





  }




