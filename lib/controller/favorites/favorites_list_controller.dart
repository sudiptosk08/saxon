import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/favorites/state/favorites_list_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final favoritesListProvider = StateNotifierProvider<FavoritesListController, FavoritesListState>(
  (ref) => FavoritesListController(ref: ref),
);

class FavoritesListController extends StateNotifier<FavoritesListState> {
  final Ref? ref;
  FavoritesListController({this.ref}) : super(FavoritesListInitialState());

  List<ProductModel> favoriteProductsList = [];

  Future fetchMyFavorites() async {
    state = FavoritesListLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getFavoriteProducts),
      );
      if (responseBody != null) {
        favoriteProductsList = (responseBody as List<dynamic>).map((x) => ProductModel.fromJson(x)).toList();

        state = FavoritesListSuccessState(favoriteProductsList);
      } else {
        state = FavoritesListErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = FavoritesListErrorState();
    }
  }

  updateFavoriteProductsList(favoriteProducts) {
    state = FavoritesListSuccessState(favoriteProducts);
  }
}
