import 'package:flutter/cupertino.dart';
import 'package:neostore/bloc/form_status.dart';
import 'package:neostore/model/product.dart';

class HomeState {
  Product? product;

  HomeState({this.product});
}

class ProductFailureState extends HomeState {
  String? error;
  ProductFailureState(this.error);
}
