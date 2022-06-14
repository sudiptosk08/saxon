import 'package:saxonmarket/models/product_model.dart';

abstract class FavoritesListState {
  const FavoritesListState();
}

class FavoritesListInitialState extends FavoritesListState {
  const FavoritesListInitialState();
}

class FavoritesListLoadingState extends FavoritesListState {
  const FavoritesListLoadingState();
}

class FavoritesListSuccessState extends FavoritesListState {
  final List<ProductModel> favoriteProductsList;
  const FavoritesListSuccessState(this.favoriteProductsList);
}

class FavoritesListErrorState extends FavoritesListState {
  const FavoritesListErrorState();
}
