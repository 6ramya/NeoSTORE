import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? status;
  dynamic? data;
  String? message;
  String? userMsg;

  User({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        data: json['data'] != null
            ? json['data'].runtimeType == bool
                ? false
                : Data.fromJson(json['data'])
            : null,
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
        "user_msg": userMsg,
      };
}

Data DataFromJson(String str) => Data.fromJson(json.decode(str));

String DataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.profilePic,
    this.countryId,
    this.gender,
    this.phoneNo,
    this.dob,
    this.isActive,
    this.created,
    this.modified,
    this.accessToken,
  });

  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  dynamic? profilePic;
  dynamic? countryId;
  String? gender;
  String? phoneNo;
  dynamic? dob;
  bool? isActive;
  String? created;
  String? modified;
  String? accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        roleId: json["role_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        username: json["username"],
        profilePic: json["profile_pic"],
        countryId: json["country_id"],
        gender: json["gender"],
        phoneNo: json["phone_no"],
        dob: json["dob"],
        isActive: json["is_active"],
        created: json["created"],
        modified: json["modified"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "username": username,
        "profile_pic": profilePic,
        "country_id": countryId,
        "gender": gender,
        "phone_no": phoneNo,
        "dob": dob,
        "is_active": isActive,
        "created": created,
        "modified": modified,
        "access_token": accessToken,
      };
}
