import 'package:equatable/equatable.dart';
import 'package:neostore/bloc/product_state.dart';
import 'package:neostore/model/cart.dart';
import 'package:neostore/model/list_cart_items.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();

  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();

  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  CartItems? cartItems;

  CartLoaded({this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}

class AddToCartState extends CartState {
  Cart? cart;

  AddToCartState({
    this.cart,
  });

  @override
  List<Object?> get props => [cart];
}


