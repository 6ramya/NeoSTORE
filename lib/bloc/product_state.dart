import 'package:neostore/bloc/form_status.dart';
import 'package:neostore/model/product_detail.dart';

class ProductState {
  String? id;
  ProductDetail? productDetail;
  FormStatus? formStatus;

  ProductState(
      {this.id,
      this.productDetail,
      this.formStatus = const InitialFormStatus()});

  ProductState copyWith(
      {ProductDetail? productDetail, FormStatus? formStatus}) {
    return ProductState(
        productDetail: productDetail ?? this.productDetail,
        formStatus: formStatus ?? this.formStatus);
  }
}

class ProductFailure extends ProductState {
  String? error;
  ProductFailure({this.error});
}
