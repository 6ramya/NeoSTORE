import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/product_event.dart';
import 'package:neostore/bloc/product_state.dart';
import 'package:neostore/bloc/form_status.dart';

import 'package:neostore/model/product_detail.dart';
import 'package:neostore/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository? authRepo;
  ProductBloc({this.authRepo}) : super(ProductState());

  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ButtonClick) {

      yield ProductState(id: event.id);
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        ProductDetail? productsDetail =
            await authRepo!.getProductDetail(id: event.id);
        if (productsDetail!.status == 200) {
          yield state.copyWith(
              formStatus: SubmissionSuccess(), productDetail: productsDetail);
        
        }
      } on Exception catch (e) {}
    }
  }
}
