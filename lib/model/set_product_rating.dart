import 'dart:convert';

SetProductRating setProductRatingFromJson(String str) =>
    SetProductRating.fromJson(json.decode(str));

class SetProductRating {
  int? status;
  Data? data;
  String? message;
  String? user_msg;

  SetProductRating({this.status, this.data, this.message, this.user_msg});

  factory SetProductRating.fromJson(Map<String, dynamic> json) {
    return SetProductRating(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
      user_msg: json['user_msg'],
    );
  }
}

class Data {
  int? id;
  int? product_category_id;
  String? name;
  String? producer;
  String? description;
  int? cost;
  double? rating;
  int? view_count;
  String? created;
  String? modified;
  String? product_images;

  Data(
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
      this.product_images});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
        product_images: json['product_images']);
  }
}
