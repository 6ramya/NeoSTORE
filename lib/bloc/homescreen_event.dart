import 'package:flutter/cupertino.dart';
import 'package:neostore/bloc/form_status.dart';
import 'package:neostore/model/product.dart';

abstract class HomeEvent {}

class ButtonClicked extends HomeEvent {
  String? id;

  ButtonClicked({
    this.id,
  });
}
