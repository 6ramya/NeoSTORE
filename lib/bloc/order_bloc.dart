import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/order_event.dart';
import 'package:neostore/bloc/order_state.dart';
import 'package:neostore/repository/order_repository.dart';
import 'package:neostore/model/order_detail.dart';
import 'package:neostore/model/order_list.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository? authRepo;
  OrderBloc({this.authRepo}) : super(OrderInitial());

  @override
  OrderState get initialState => OrderInitial();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is placeOrder) {
      try {
        await authRepo!
            .placeOrder(accessToken: event.token, address: event.address);
      } on Exception catch (e) {}
    } else if (event is getOrderList) {
      yield OrderListLoading();
      try {
        OrderList? orders =
            await authRepo!.getOrderList(accessToken: event.token);
        yield OrderListLoaded(order: orders);
      } on Exception catch (e) {}
    } else if (event is getOrderDetail) {
      yield OrderDetailLoading();
      try {
        OrderDetail? orderDetailed = await authRepo!
            .getOrderDetail(accessToken: event.token, orderId: event.orderId);
        yield OrderDetailLoaded(orderDetail: orderDetailed);
      } on Exception catch (e) {}
    }
  }
}
