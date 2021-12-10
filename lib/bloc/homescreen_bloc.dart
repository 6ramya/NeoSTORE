import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/homescreen_event.dart';
import 'package:neostore/bloc/homescreen_state.dart';
import 'package:neostore/bloc/form_status.dart';

import 'package:neostore/model/product.dart';
import 'package:neostore/repository/product_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ProductRepository? authRepo;
  HomeBloc({required this.authRepo}) : super(HomeState());

  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ButtonClicked) {
      try {
        Product? products = await authRepo!.getProducts(id: event.id);
        if (products!.status == 200) {
          yield HomeState(product: products);
        }
      } on Exception catch (e) {
        yield ProductFailureState(e.toString());
      }
    }
  }
}
