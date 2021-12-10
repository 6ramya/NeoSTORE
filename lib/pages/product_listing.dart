import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:neostore/bloc/homescreen_bloc.dart';
import 'package:neostore/bloc/homescreen_state.dart';
import 'package:neostore/bloc/product_bloc.dart';
import 'package:neostore/bloc/product_event.dart';
import 'package:neostore/bloc/product_state.dart';
import 'package:neostore/bloc/form_status.dart';

import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/colors.dart';
import 'package:neostore/model/product.dart';
import 'package:neostore/model/product_detail.dart';

import 'package:neostore/pages/account_page.dart';
import 'package:neostore/pages/cart_page.dart';

import 'package:neostore/pages/product_detailed.dart';
import 'package:neostore/repository/product_repository.dart';
import 'package:neostore/widgets/rating.dart';
import 'package:http/http.dart' as http;

class ProductListing extends StatefulWidget {
  Product? product;
  String? title;
  String? userId;

  ProductListing({Key? key, this.product, this.title, this.userId})
      : super(key: key);

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  List<Data>? data;
  int? len;

  @override
  void initState() {
    data = widget.product!.data!.map((e) => e).toList();
    len = data!.length;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors().DarkRed,
            title: Text('${widget.title}',
                style: TextStyle(fontWeight: FontWeight.w500)),
            centerTitle: true,
            actions: [Icon(Icons.search)],
          ),
          body: BlocProvider<ProductBloc>(
              create: (context) =>
                  ProductBloc(authRepo: context.read<ProductRepository>()),
              child: BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                if (state.productDetail != null) {
                  Navigator.pushNamed(context, '/productDetail',
                      arguments: ProductDetailArguments(
                          product: state.productDetail,
                          title: '${widget.title}',
                          userId: '${widget.userId}'));
                }
              }, builder: (context, state) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return widget.product!.data != null
                          ? buildItem(
                              index: index,
                              url: '${data![index].productImages}',
                              text: '${data![index].name}',
                              description: '${data![index].producer}',
                              price: 'Rs ${data![index].cost}',
                              rating: data![index].rating,
                              onTap: () {
                                context.read<ProductBloc>().add(ButtonClick(
                                    id: '${widget.product!.data![index].id}'));
                              })
                          : CircularProgressIndicator();
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black,
                      );
                    },
                    itemCount: data!.length);
              }))),
      designSize: const Size(1080, 1920),
    );
  }

  Widget buildItem(
      {String? url,
      String? text,
      String? description,
      String? price,
      int? index,
      int? rating,
      Function? onTap}) {
    ProductDetail? product;
    TextStyle style1 = TextStyle(
        fontSize: 45.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Gotham',
        color: AppColors().MediumGrey);
    TextStyle style2 = TextStyle(
        fontSize: 30.sp,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w200,
        color: AppColors().MediumGrey);
    TextStyle style3 = TextStyle(
        fontSize: 60.sp,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w500,
        color: AppColors().MediumRed);

    return Container(
        height: 380.h,
        child: InkWell(
          onTap: () => onTap!(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.h, top: 30.h, bottom: 30.h),
                child: Row(
                  children: [
                    Image.network(url!, height: 320.h, width: 320.w),
                    Padding(
                      padding: EdgeInsets.all(30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text!,
                                style: style1,
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                description!,
                                style: style2,
                              ),
                            ],
                          ),
                          SizedBox(height: 105.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                price!,
                                style: style3,
                              ),
                              SizedBox(width: 160.w),
                              Rating(
                                rating: rating,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
