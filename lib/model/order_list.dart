import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

class OrderList {
  int? status;
  List<OrderData>? data;
  String? message;
  String? user_msg;

  OrderList({this.status, this.data, this.message, this.user_msg});

  factory OrderList.fromJson(Map<String, dynamic> json) {
    return OrderList(
        status: json['status'],
        data: json['data'] != null
            ? List<OrderData>.from(
                json['data'].map((x) => OrderData.fromJson(x)))
            : null,
        message: json['message'],
        user_msg: json['user_msg']);
  }
}

class OrderData {
  int? id;
  int? cost;
  String? created;

  OrderData({this.id, this.cost, this.created});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
        id: json['id'], cost: json['cost'], created: json['created']);
  }
}
