import 'package:equatable/equatable.dart';
import 'package:neostore/model/order.dart';
import 'package:neostore/model/order_list.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class placeOrder extends OrderEvent {
  String? token;
  String? address;
  placeOrder({this.token, this.address});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class getOrderList extends OrderEvent {
  String? token;
  // final OrderList order;
  getOrderList({this.token});
  @override
  List<Object> get props => [];
}

class getOrderDetail extends OrderEvent {
  String? token;
  int? orderId;
  getOrderDetail({this.token, this.orderId});
  @override
  List<Object> get props => [];
}
