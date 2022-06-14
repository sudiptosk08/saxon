abstract class OrdersListState {
  const OrdersListState();
}

class OrdersListInitialState extends OrdersListState {
  const OrdersListInitialState();
}

class OrdersListLoadingState extends OrdersListState {
  const OrdersListLoadingState();
}

class OrdersListSuccessState extends OrdersListState {
  const OrdersListSuccessState();
}

class OrdersListErrorState extends OrdersListState {
  const OrdersListErrorState();
}
