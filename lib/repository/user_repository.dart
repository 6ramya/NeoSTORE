import 'dart:convert';

import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/account_details.dart';
import 'package:neostore/model/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<User?> PostData(String? username, String? password) async {
    var url =
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/users/login');
    final response =
        await http.post(url, body: {'email': username, 'password': password});
    int code = response.statusCode;
    if (response.statusCode == 200) {
      var responseJson = userFromJson(response.body);
      await UserPreferences.setProfilePicture(responseJson);

      return responseJson;
    } else {
      var responseJson = userFromJson(response.body);
      throw Exception('${responseJson.userMsg}');
    }
  }

  Future<User?> ForgotPasswrd({String? email}) async {
    final response = await http.post(
        Uri.parse(
            'http://staging.php-dev.in:8844/trainingapp/api/users/forgot'),
        body: {'email': email});

    var responseJson = userFromJson(response.body);

    return responseJson;
  }

  Future<User?> PostRegistrationData(
      String? firstname,
      String? lastname,
      String? email,
      String? password,
      String? confirmPassword,
      String? genderr,
      String? phNumber) async {
    var url = Uri.parse(
        'http://staging.php-dev.in:8844/trainingapp/api/users/register');
    final response = await http.post(url, body: {
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'gender': genderr,
      'phone_no': phNumber
    });

    if (response.statusCode == 200) {
      var responseJson = userFromJson(response.body);

      return responseJson;
    } else {
      var responseJson = userFromJson(response.body);

      throw Exception('${responseJson.userMsg}');
    }
  }

  Future<AccountDetails?> getAccountDetails({String? accessToken}) async {
    final url =
        'http://staging.php-dev.in:8844/trainingapp/api/users/getUserData';

    final response =
        await http.get(Uri.parse(url), headers: {'access_token': accessToken!});
    if (response.statusCode == 200) {
      final responseJson = accountDetailsFromJson(response.body);

      await UserPreferences.setCartItems(responseJson.data.total_carts);

      return responseJson;
    } else {
      final responseJson = jsonDecode(response.body);

      return responseJson;
    }
  }

  Future<AccountDetails?> UpdateAccountInfo(
      {AccountDetails? accountInfo,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNo,
      String? dob,
      String? profile_pic,
      String? accessToken}) async {
    final response = await http.post(
        Uri.parse(
            'http://staging.php-dev.in:8844/trainingapp/api/users/update'),
        headers: {
          'access_token': accessToken!
        },
        body: {
          'first_name': firstName!.isEmpty
              ? accountInfo!.data.userData.first_name
              : firstName,
          'last_name': lastName!.isEmpty
              ? accountInfo!.data.userData.last_name
              : lastName,
          'email': email!.isEmpty ? accountInfo!.data.userData.email : email,
          'phone_no':
              phoneNo!.isEmpty ? accountInfo!.data.userData.phone_no : phoneNo,
          'dob': dob!.isEmpty ? '${accountInfo!.data.userData.dob}' : dob,
          'profile_pic': profile_pic == null
              ? accountInfo!.data.userData.profile_pic
              : profile_pic
        });

    if (response.statusCode == 200) {
      final responseJson = accountDetailsFromJson(response.body);

      return responseJson;
    } else {
      final responseJson = accountDetailsFromJson(response.body);

      return responseJson;
    }
  }

  Future<void> resetPassword(
      {String? token,
      String? password,
      String? newPassword,
      String? confirmPassword}) async {
    final response = await http.post(
        Uri.parse(
            'http://staging.php-dev.in:8844/trainingapp/api/users/change'),
        headers: <String, String>{
          'access_token': token!,
        },
        body: {
          'old_password': password,
          'password': newPassword,
          'confirm_password': confirmPassword
        });
    var responseJson = userFromJson(response.body);
  }
}
