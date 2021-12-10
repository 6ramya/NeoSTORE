import 'dart:convert';

ProductDetail productDetailFromJson(String str) =>
    ProductDetail.fromJson(json.decode(str));

class ProductDetail {
  int? status;
  Data1? data;

  ProductDetail({this.status, this.data});

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
        status: json['status'], data: Data1.fromJson(json['data']));
  }
}

class Data1 {
  int? id;
  int? product_category_id;
  String? name;
  String? producer;
  String? description;
  int? cost;
  int? rating;
  int? view_count;
  String? created;
  String? modified;
  List<Images>? product_images;
  String? message;
  String? user_msg;

  Data1(
      {this.id,
      this.product_category_id,
      this.name,
      this.producer,
      this.description,
      this.cost,
      this.rating,
      this.view_count,
      this.created,
      this.modified,
      this.product_images,
      this.message,
      this.user_msg});

  factory Data1.fromJson(Map<String, dynamic> json) {
    return Data1(
        id: json['id'],
        product_category_id: json['product_category_id'],
        name: json['name'],
        producer: json['producer'],
        description: json['description'],
        cost: json['cost'],
        rating: json['rating'],
        view_count: json['view_count'],
        created: json['created'],
        modified: json['modified'],
        product_images: List<Images>.from(
            json['product_images'].map((e) => Images.fromJson(e))),
        message: json['message'],
        user_msg: json['user_msg']);
  }
}

class Images {
  int? id;
  int? product_id;
  String? image;
  String? created;
  String? modified;

  Images({this.id, this.product_id, this.image, this.created, this.modified});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        id: json['id'],
        product_id: json['product_id'],
        image: json['image'],
        created: json['created'],
        modified: json['modified']);
  }
}
