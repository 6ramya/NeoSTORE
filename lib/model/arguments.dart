import 'package:neostore/model/product.dart';
import 'package:neostore/model/product_detail.dart';

import 'account_details.dart';

class EditProfileArguments {
  AccountDetails? accountInfo;
  String? userId;

  EditProfileArguments({this.accountInfo, this.userId});
}

class HomeScreenArguments {
  String? userId;
  HomeScreenArguments({this.userId});
}

class OrderDetailArguments {
  String? userId;
  int? orderId;

  OrderDetailArguments({this.orderId, this.userId});
}

class ProductDetailArguments {
  ProductDetail? product;
  String? title;
  String? userId;

  ProductDetailArguments({this.product, this.title, this.userId});
}

class ProductListArguments {
  Product? product;
  String? title;
  String? userId;

  ProductListArguments({this.product, this.title, this.userId});
}
