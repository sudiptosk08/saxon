import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/orders/state/check_promo_state.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final checkPromoProvider = StateNotifierProvider<CheckPromoController, CheckPromoState>(
  (ref) => CheckPromoController(ref: ref),
);

class CheckPromoController extends StateNotifier<CheckPromoState> {
  final Ref? ref;
  CheckPromoController({this.ref}) : super(CheckPromoInitialState());

  Future checkPromo(promoCode, userId) async {
    state = CheckPromoLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.checkPromoCode(promoCode: promoCode, userId: userId)),
      );
      if (responseBody != null) {
        state = CheckPromoSuccessState();
      } else {
        state = CheckPromoErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = CheckPromoErrorState();
    }
  }
}
