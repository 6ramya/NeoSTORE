import 'dart:convert';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

class OrderDetail {
  int? status;
  OrderDetailData? data;
  String? message;
  String? user_msg;

  OrderDetail({this.status, this.data, this.message, this.user_msg});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
        status: json['status'],
        data: OrderDetailData.fromJson(json['data']),
        message: json['message'],
        user_msg: json['user_msg']);
  }
}

class OrderDetailData {
  int? id;
  int? cost;
  int? created;
  List<OrderDetails>? order_details;

  OrderDetailData({this.id, this.cost, this.created, this.order_details});

  factory OrderDetailData.fromJson(Map<String, dynamic> json) {
    return OrderDetailData(
        id: json['id'],
        cost: json['cost'],
        created: json['created'],
        order_details: List<OrderDetails>.from(
            json['order_details'].map((x) => OrderDetails.fromJson(x))));
  }
}

class OrderDetails {
  int? id;
  int? product_id;
  int? quantity;
  int? total;
  String? prod_name;
  String? prod_cat_name;
  String? prod_image;

  OrderDetails(
      {this.id,
      this.product_id,
      this.quantity,
      this.total,
      this.prod_name,
      this.prod_cat_name,
      this.prod_image});

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
        id: json['id'],
        product_id: json['product_id'],
        quantity: json['quantity'],
        total: json['total'],
        prod_name: json['prod_name'],
        prod_cat_name: json['prod_cat_name'],
        prod_image: json['prod_image']);
  }
}
