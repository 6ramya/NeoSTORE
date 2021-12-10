import 'package:neostore/bloc/form_status.dart';

abstract class ProductEvent {}

class ButtonClick extends ProductEvent {
  String? id;
  ButtonClick({this.id});
}

class ProductListLoaded extends ProductEvent {
  FormStatus? formStatus;
  ProductListLoaded({this.formStatus});
}
