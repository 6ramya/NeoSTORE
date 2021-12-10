import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/cart.dart';
import 'package:http/http.dart' as http;
import 'package:neostore/model/list_cart_items.dart';
import 'package:neostore/model/set_product_rating.dart';

class CartRepository {
  Future<Cart?> addToCart(
      {String? accessToken, String? quantity, String? productId}) async {
   
    final url =
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/addToCart');
    final response = await http.post(url,
        headers: {'access_token': accessToken!},
        body: {'product_id': productId!, 'quantity': quantity!});
    if (response.statusCode == 200) {
      final responseJson = cartFromJson(response.body);
      await UserPreferences.setCartItems(responseJson.total_carts);

      return responseJson;
    } else {
      final responseJson = cartFromJson(response.body);
      await UserPreferences.setCartItems(responseJson.total_carts);

      return responseJson;
    }
  }

  Future<CartItems?> listCartItems({String? accessToken}) async {
    final response = await http.get(
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/cart'),
        headers: {'access_token': accessToken!});
    final responseJson = cartItemsFromJson(response.body);
    return responseJson;
  }

  Future<Cart?> editCart(
      {String? accessToken, int? product_id, int? quantity}) async {
    final response = await http.post(
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/editCart'),
        headers: {'access_token': accessToken!},
        body: {'product_id': '$product_id', 'quantity': '$quantity'});
    final responseJson = cartFromJson(response.body);
    await UserPreferences.setCartItems(responseJson.total_carts);

    return responseJson;
  }

  Future<void> deleteCart({String? accessToken, int? product_id}) async {
    final response = await http.post(
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/deleteCart'),
        headers: {'access_token': accessToken!},
        body: {'product_id': '$product_id'});
    final responseJson = cartFromJson(response.body);
    await UserPreferences.setCartItems(responseJson.total_carts);
 
  }

  Future<void> setProductRating({String? product_id, double? rating}) async {
    final response = await http.post(
        Uri.parse(
            'http://staging.php-dev.in:8844/trainingapp/api/products/setRating'),
        body: {'product_id': product_id, 'rating': '$rating'});
    final responseJson = setProductRatingFromJson(response.body);
    
  }
}
