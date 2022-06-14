import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/favorites/favorites_list_controller.dart';
import 'package:saxonmarket/controller/favorites/state/favorites_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final favoritesProvider = StateNotifierProvider<FavoritesController, FavoritesState>(
  (ref) => FavoritesController(ref: ref),
);

class FavoritesController extends StateNotifier<FavoritesState> {
  final Ref? ref;
  FavoritesController({this.ref}) : super(FavoritesInitialState());

  Future addProductToFavorites(ProductModel product) async {
    state = FavoritesLoadingState();
    var responseBody;
    var requestBody = {
      "productId": product.id,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.addProductToFavorites, requestBody),
      );
      if (responseBody != null) {
        List<ProductModel> favoriteProductsList = ref!.read(favoritesListProvider.notifier).favoriteProductsList;
        favoriteProductsList.add(product);
        ref!.read(favoritesListProvider.notifier).updateFavoriteProductsList(favoriteProductsList);
        state = FavoritesSuccessState();
      } else {
        state = FavoritesErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = FavoritesErrorState();
    }
  }

  Future removeProductFromFavorites(int productId) async {
    state = FavoritesLoadingState();
    var responseBody;

    try {
      responseBody = await Network.handleResponse(
        await Network.deleteRequest(API.removeProductFromFavorites(productId)),
      );
      if (responseBody != null) {
        List<ProductModel> favoriteProductsList = ref!.read(favoritesListProvider.notifier).favoriteProductsList;
        favoriteProductsList.removeWhere((element) => element.id == productId);
        ref!.read(favoritesListProvider.notifier).updateFavoriteProductsList(favoriteProductsList);
        state = FavoritesSuccessState();
      } else {
        state = FavoritesErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = FavoritesErrorState();
    }
  }
}
