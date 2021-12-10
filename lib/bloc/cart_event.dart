import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddToCart extends CartEvent {
  String? id;
  String? quant;
  String? token;

  AddToCart({
    this.id,
    this.quant,
    this.token,
  });

  @override
  List<Object?> get props => [];
}

class RateEvent extends CartEvent {
  String? product_id;
  double? rating;
  RateEvent({this.product_id, this.rating});

  @override
  List<Object?> get props => [];
}

class LoadItems extends CartEvent {
  String? token;
  LoadItems({this.token});

  @override
  List<Object?> get props => [];
}

class EditCart extends CartEvent {
  int? product_id;
  int? quantity;
  String? token;
  EditCart({this.product_id, this.quantity, this.token});

  @override
  List<Object?> get props => [];
}

class DeleteCart extends CartEvent {
  int? product_id;
  String? token;
  DeleteCart({this.product_id, this.token});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
