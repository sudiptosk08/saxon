abstract class CheckPromoState {
  const CheckPromoState();
}

class CheckPromoInitialState extends CheckPromoState {
  const CheckPromoInitialState();
}

class CheckPromoLoadingState extends CheckPromoState {
  const CheckPromoLoadingState();
}

class CheckPromoSuccessState extends CheckPromoState {
  const CheckPromoSuccessState();
}

class CheckPromoErrorState extends CheckPromoState {
  const CheckPromoErrorState();
}
