import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/orders/state/orders_list_state.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final ordersListProvider = StateNotifierProvider<OrdersListController, OrdersListState>(
  (ref) => OrdersListController(ref: ref),
);

class OrdersListController extends StateNotifier<OrdersListState> {
  final Ref? ref;
  OrdersListController({this.ref}) : super(OrdersListInitialState());

  List ordersList = [];

  Future fetchOrdersList() async {
    state = OrdersListLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getOrders()),
      );
      if (responseBody != null) {
        state = OrdersListSuccessState();
      } else {
        state = OrdersListErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = OrdersListErrorState();
    }
  }
}
