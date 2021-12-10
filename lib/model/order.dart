import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

class Order {
  int? status;
  String? message;
  String? user_msg;

  Order({this.status, this.message, this.user_msg});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        status: json['status'],
        message: json['message'],
        user_msg: json['user_msg']);
  }
}
