import 'package:http/http.dart' as http;
import 'package:neostore/model/product.dart';
import 'package:neostore/model/product_detail.dart';
import 'package:neostore/model/set_product_rating.dart';

class ProductRepository {
  Future<Product?> getProducts({String? id}) async {
    Map<String, String> parameters = {
      'product_category_id': id!,
      'limit': '10',
      'page': '1'
    };
    final url =
        'http://staging.php-dev.in:8844/trainingapp/api/products/getList';

    String query = Uri(queryParameters: parameters).query;
    final requestUrl = url + '?' + query;
    final response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      final responseJson = productFromJson(response.body);

      return responseJson;
    } else {
      final responseJson = productFromJson(response.body);

      return responseJson;
    }
  }

  Future<ProductDetail?> getProductDetail({String? id}) async {
    Map<String, String> parameter = {'product_id': id!};
    final url =
        'http://staging.php-dev.in:8844/trainingapp/api/products/getDetail';
    String query = Uri(queryParameters: parameter).query;
    final requestUrl = url + '?' + query;
    final response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      final responseJson = productDetailFromJson(response.body);

      return responseJson;
    } else {
      final responseJson = productDetailFromJson(response.body);

      return responseJson;
    }
  }
}
