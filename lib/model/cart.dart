import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

class Cart {
  int? status;
  bool? data;
  int? total_carts;
  String? message;
  String? user_msg;

  Cart({this.status, this.data, this.total_carts, this.message, this.user_msg});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        status: json['status'],
        data: json['data'] != null ? json['data'] : null,
        total_carts: json['total_carts'],
        message: json['message'],
        user_msg: json['user_msg']);
  }
}
