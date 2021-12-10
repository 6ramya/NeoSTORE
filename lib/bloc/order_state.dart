import 'package:equatable/equatable.dart';
import 'package:neostore/model/order.dart';
import 'package:neostore/model/order_detail.dart';
import 'package:neostore/model/order_list.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  const OrderInitial();
  @override
  List<Object> get props => [];
}

class OrderListLoading extends OrderState {
  const OrderListLoading();

  @override
  List<Object> get props => [];
}

class OrderListLoaded extends OrderState {
  OrderList? order;
  OrderListLoaded({this.order});
  @override
  List<Object> get props => [order!];
}

class OrderDetailLoading extends OrderState {
  const OrderDetailLoading();
  @override
  List<Object> get props => [];
}

class OrderDetailLoaded extends OrderState {
  OrderDetail? orderDetail;
  OrderDetailLoaded({this.orderDetail});
  @override
  List<Object> get props => [orderDetail!];
}
