import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/review/state/review_state.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final reviewProvider = StateNotifierProvider<ReviewController, ReviewState>(
  (ref) => ReviewController(ref: ref),
);

class ReviewController extends StateNotifier<ReviewState> {
  final Ref? ref;
  ReviewController({this.ref}) : super(ReviewInitialState());

  Future addProductReview(int productId, String review, rating) async {
    state = ReviewLoadingState();
    var responseBody;
    var requestBody = {"productId": productId, "body": review, "rating": rating};

    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.addProductReview, requestBody),
      );
      if (responseBody != null) {
        state = ReviewSuccessState();
      } else {
        state = ReviewErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = ReviewErrorState();
    }
  }
}
