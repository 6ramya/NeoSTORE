import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/cart_event.dart';
import 'package:neostore/bloc/cart_state.dart';

import 'package:neostore/model/cart.dart';
import 'package:neostore/model/list_cart_items.dart';
import 'package:neostore/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository? authRepo;
  CartBloc({required this.authRepo}) : super(CartInitial());

  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadItems) {
      yield CartLoading();
      try {
        CartItems? items =
            await authRepo!.listCartItems(accessToken: event.token);
        yield CartLoaded(cartItems: items);
      } on Exception catch (e) {}
    } else if (event is AddToCart) {
      try {
        Cart? myCart = await authRepo!.addToCart(
            productId: event.id,
            quantity: event.quant,
            accessToken: event.token);
     
        yield AddToCartState(cart: myCart);
      } on Exception catch (e) {}
    } else if (event is RateEvent) {
      try {
        await authRepo!.setProductRating(
            product_id: event.product_id, rating: event.rating);
      } on Exception catch (e) {}
    } else if (event is EditCart) {
      try {
        Cart? cart = await authRepo!.editCart(
            accessToken: event.token,
            quantity: event.quantity,
            product_id: event.product_id);
      } on Exception catch (e) {}
    } else if (event is DeleteCart) {
     
      await authRepo!
          .deleteCart(accessToken: event.token, product_id: event.product_id);
    }
  }
}
