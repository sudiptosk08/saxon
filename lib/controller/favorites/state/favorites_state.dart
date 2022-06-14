abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesInitialState extends FavoritesState {
  const FavoritesInitialState();
}

class FavoritesLoadingState extends FavoritesState {
  const FavoritesLoadingState();
}

class FavoritesSuccessState extends FavoritesState {
  const FavoritesSuccessState();
}

class FavoritesErrorState extends FavoritesState {
  const FavoritesErrorState();
}
