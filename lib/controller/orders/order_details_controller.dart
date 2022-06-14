import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/orders/state/order_details_state.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

class OrderDetailsController extends StateNotifier<OrderDetailsState> {
  final Ref? ref;
  OrderDetailsController({this.ref}) : super(OrderDetailsInitialState());

  var orderDetails;

  Future fetchOrderDetails(int orderId) async {
    state = OrderDetailsLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getOrders(orderId: orderId)),
      );
      if (responseBody != null) {
        state = OrderDetailsSuccessState();
      } else {
        state = OrderDetailsErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = OrderDetailsErrorState();
    }
  }
}
