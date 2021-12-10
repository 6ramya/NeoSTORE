import 'dart:convert';

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));

class CartItems {
  int? status;
  List<Data1>? data;
  int? count;
  int? total;
  String? message;
  String? user_msg;

  CartItems(
      {this.status,
      this.data,
      this.count,
      this.total,
      this.message,
      this.user_msg});

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
        status: json['status'],
        data: json['data'] != null
            ? List<Data1>.from(json['data'].map((x) => Data1.fromJson(x)))
                .toList()
            : null,
        message: json['message'],
        user_msg: json['user_msg'],
        count: json['count'],
        total: json['total']);
  }
}

class Data1 {
  int? id;
  int? product_id;
  int? quantity;
  Products? product;

  Data1({
    this.id,
    this.product_id,
    this.quantity,
    this.product,
  });

  factory Data1.fromJson(Map<String, dynamic> json) {
    return Data1(
      id: json['id'],
      product_id: json['product_id'],
      quantity: json['quantity'],
      product: Products.fromJson(json['product']),
    );
  }
}

class Products {
  int? id;
  String? name;
  int? cost;
  String? product_category;
  String? product_images;
  int? sub_total;

  Products(
      {this.id,
      this.name,
      this.cost,
      this.product_category,
      this.product_images,
      this.sub_total});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        id: json['id'],
        name: json['name'],
        cost: json['cost'],
        product_category: json['product_category'],
        product_images: json['product_images'],
        sub_total: json['sub_total']);
  }
}
