import 'dart:convert';
import 'package:neostore/model/account_details.dart';
import 'package:neostore/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future removeTotalCart() async => await _preferences!.remove(_keyCart);
  static Future removeProfilePic() async =>
      await _preferences!.remove(_imageKey);
  static Future removeAddressList() async =>
      await _preferences!.remove(_addressListKey);
  static Future removeAddress() async =>
      await _preferences!.remove(_addressKey);

  static const _keyCart = 'total_carts';
  static const _addressKey = 'addressKey';
  static const _addressListKey = 'addressList';
  static const _imageKey = 'profile_pic';

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    final userId = (user.data.id).toString();

    await _preferences!.setString(userId, json);
  }

  static User getUser(String UserId) {
    final json = _preferences!.getString(UserId);
    return User.fromJson(jsonDecode(json!));
  }

  static Future setCartItems(int? cartItems) async {
    int total_carts = cartItems == null ? 0 : cartItems;
    await _preferences!.setInt(_keyCart, total_carts);
  }

  static int? getCartItems() => _preferences!.getInt(_keyCart);

  static Future setAddress(String? address) async {
    await _preferences!.setString(_addressKey, address!);
  }

  static Future setAddressList(String? address) async {
    final addressList =
        _preferences!.getStringList(_addressListKey) ?? <String>[];
    final newAddressList = List.of(addressList)..add(address!);

    await _preferences!.setStringList(_addressListKey, newAddressList);
  }

  static String? getAddress() => _preferences!.getString(_addressKey);

  static List<String?> getAddressList() {
    final response = _preferences!.getStringList(_addressListKey);

    if (response == null) {
      return <String>[];
    } else {
      return response;
    }
  }

  static Future deleteAddress(String? address) async {
    final response = _preferences!.getStringList(_addressListKey) ?? <String>[];
    final newAddressList = List.of(response)..remove(address);

    await _preferences!.setStringList(_addressListKey, newAddressList);
  }

  static Future setProfilePicture(User user) async {
    final json = jsonEncode(user.toJson());
    final imagePath = (user.data.profilePic).toString();
    String image = imagePath.isEmpty || imagePath.contains('null')
        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
        : imagePath;
    await _preferences!.setString(_imageKey, image);
  }

  static String? getProfilePicture() => _preferences!.getString(_imageKey);
}
