import 'dart:convert';

AccountDetails accountDetailsFromJson(String str) =>
    (AccountDetails.fromJson(json.decode(str)));

class AccountDetails {
  int? status;
  dynamic? data;
  String? message;
  String? user_msg;

  AccountDetails({this.status, this.data, this.message, this.user_msg});

  factory AccountDetails.fromJson(Map<String, dynamic> json) {
    return AccountDetails(
        status: json['status'],
       
        data: json['data'] != null
            ? json['data'].runtimeType == bool
                ? false
                : Data.fromJson(json['data'])
            : null,
        message: json['message'],
        user_msg: json['user_msg']);
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
        "user_msg": user_msg
      };
}

class Data {
  UserData? userData;
  int? total_carts;
  int? total_orders;

  Data({this.userData, this.total_carts, this.total_orders});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        userData: json['user_data'] != null
            ? UserData.fromJson(json['user_data'])
            : null,
        total_carts: json['total_carts'],
        total_orders: json['total_orders']);
  }

  Map<String, dynamic> toJson() => {
        "userData": userData!.toJson(),
        "total_carts": total_carts,
        "total_orders": total_orders
      };
}

class UserData {
  int? id;
  int? role_id;
  String? first_name;
  String? last_name;
  String? email;
  String? profile_pic;
  String? country_id;
  String? username;
  String? gender;
  String? phone_no;
  String? dob;
  bool? is_active;
  String? created;
  String? modified;
  String? access_token;
  dynamic? product_categories;

  UserData(
      {this.id,
      this.role_id,
      this.first_name,
      this.last_name,
      this.email,
      this.profile_pic,
      this.country_id,
      this.username,
      this.gender,
      this.phone_no,
      this.dob,
      this.is_active,
      this.created,
      this.modified,
      this.access_token,
      this.product_categories});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        role_id: json['role_id'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        email: json['email'],
        profile_pic: json['profile_pic'],
        country_id: json['country_id'],
        username: json['username'],
        gender: json['gender'],
        phone_no: json['phone_no'],
        dob: json['dob'],
        is_active: json['is_active'],
        created: json['created'],
        modified: json['modified'],
        access_token: json['access_token'],
        product_categories: json['product_categories']);
    
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": role_id,
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "profile_pic": profile_pic,
        "country_id": country_id,
        "username": username,
        "gender": gender,
        "phone_no": phone_no,
        "dob": dob,
        "is_active": is_active,
        "created": created,
        "modified": modified,
        "access_token": access_token,
        "product_categories": product_categories
      };
}

class ProductCategories {
  int? id;
  String? name;
  String? icon_image;
  String? created;
  String? modified;

  ProductCategories(
      {this.id, this.name, this.icon_image, this.created, this.modified});

  factory ProductCategories.fromJson(Map<String, dynamic> json) {
    return ProductCategories(
        id: json['id'],
        name: json['name'],
        icon_image: json['icon_image'],
        created: json['created'],
        modified: json['modified']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_image": icon_image,
        "created": created,
        "modified": modified
      };
}
