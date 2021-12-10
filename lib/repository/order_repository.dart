import 'package:http/http.dart' as http;
import 'package:neostore/model/order.dart';
import 'package:neostore/model/order_detail.dart';
import 'package:neostore/model/order_list.dart';

class OrderRepository {
  Future<void> placeOrder({String? accessToken, String? address}) async {
    final response = await http.post(
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/order'),
        headers: {'access_token': accessToken!},
        body: {'address': address});
    final responseJson = orderFromJson(response.body);
  }

  Future<OrderList?> getOrderList({String? accessToken}) async {
    final response = await http.get(
        Uri.parse('http://staging.php-dev.in:8844/trainingapp/api/orderList'),
        headers: {'access_token': accessToken!});

    final responseJson = orderListFromJson(response.body);

    return responseJson;
  }

  Future<OrderDetail?> getOrderDetail(
      {String? accessToken, int? orderId}) async {
    Map<String, String> parameters = {
      'order_id': '$orderId',
    };
    String query = Uri(queryParameters: parameters).query;
    final url = 'http://staging.php-dev.in:8844/trainingapp/api/orderDetail';
    final requestUrl = url + '?' + query;

    final response = await http
        .get(Uri.parse(requestUrl), headers: {'access_token': accessToken!});
    final responseJson = orderDetailFromJson(response.body);

    return responseJson;
  }
}
