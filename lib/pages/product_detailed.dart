import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:neostore/bloc/cart_bloc.dart';
import 'package:neostore/bloc/cart_event.dart';
import 'package:neostore/bloc/cart_state.dart';

import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/cart.dart';
import 'package:neostore/model/colors.dart';
import 'package:neostore/model/product_detail.dart';
import 'package:neostore/model/set_product_rating.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/repository/cart_repository.dart';
import 'package:neostore/widgets/rating.dart';
import 'package:http/http.dart' as http;
import 'package:neostore/model/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailed extends StatefulWidget {
  ProductDetail? product;
  String? title;
  String? userId;
  ProductDetailed({Key? key, this.product, this.title, this.userId})
      : super(key: key);
  @override
  State<ProductDetailed> createState() => _ProductDetailedState();
}

class _ProductDetailedState extends State<ProductDetailed> {
  List<Images>? image;
  User? user;
  int? quantity = 1;
  int? total_carts = 0;
  double? rating;
  double? initialRating;
  TextEditingController quantityController = TextEditingController();

  void initState() {
    user = UserPreferences.getUser(widget.userId!);
    image = widget.product!.data!.product_images!.map((e) => e).toList();
    rating = (widget.product!.data!.rating)!.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: AppColors().DarkRed,
            centerTitle: true,
            title: Text(
              '${widget.product!.data!.name}',
            ),
            actions: [Icon(Icons.search)],
          ),
          body: SingleChildScrollView(
              child: BlocProvider(
            create: (context) =>
                CartBloc(authRepo: context.read<CartRepository>()),
            child: Column(
              children: [Column1(), Column2(), Column3(), Column4()],
            ),
          )),
          // ),
        );
      },
      designSize: Size(1080, 1920),
    );
  }

  Widget Column1() {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text('${widget.product!.data!.name}',
                style: TextStyle(
                  fontSize: 58.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors().DarkGrey,
                )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text('Category - ${widget.title}',
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.w200,
                  color: AppColors().MediumGrey,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${widget.product!.data!.producer}',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w200,
                    color: AppColors().MediumGrey,
                  )),
              Rating(
                rating: widget.product!.data!.rating,
              )
            ],
          )
        ],
      ),
    ));
  }

  Widget Column2() {
    return Container(
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.only(top: 25.0, left: 20, right: 20, bottom: 0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: AppColors().White,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs ${widget.product!.data!.cost}',
                          style: TextStyle(
                              color: AppColors().MediumRed,
                              fontWeight: FontWeight.w500,
                              fontSize: 50.sp),
                        ),
                        Icon(Icons.share,
                            color: AppColors().LightGrey, size: 35),
                      ],
                    ),
                    Image.network('${image![0].image}'),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: image!.length >= 3
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.network('${image![0].image}',
                                    height: 107, width: 85),
                                Image.network('${image![1].image}',
                                    height: 107, width: 85),
                                Image.network('${image![2].image}',
                                    height: 107, width: 85),
                              ],
                            )
                          : image!.length == 2
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.network('${image![0].image}',
                                        height: 107, width: 85),
                                    Image.network('${image![1].image}',
                                        height: 107, width: 85),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.network('${image![0].image}',
                                        height: 107, width: 85),
                                  ],
                                ),
                    ),
                  ],
                ),
              )),
        ));
  }

  Widget Column3() {
    return Container(
        color: Colors.grey[200],
        child: Padding(
            padding: EdgeInsets.only(top: 2, left: 20, right: 20, bottom: 20),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: AppColors().White,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('DESCRIPTION',
                            style: TextStyle(
                                color: AppColors().LightBlack,
                                fontWeight: FontWeight.w800,
                                fontSize: 40.sp)),
                      ),
                      Text(
                        '${widget.product!.data!.description}',
                        style: TextStyle(
                            color: AppColors().MediumBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 30.sp),
                      ),
                    ],
                  ),
                ))));
  }

  Widget Column4() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: BlocConsumer<CartBloc, CartState>(
                    listener: (context, state) {
              if (state is AddToCartState) {
                Fluttertoast.showToast(
                    msg: "Added to Cart!!!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.red,
                    fontSize: 12.0);
              }
            }, builder: (context, state) {
              return ElevatedButton(
                  onPressed: () async {
                    await PopUpDialog(context, '${image![0].image}',
                        '${widget.product!.data!.name}');

                    context.read<CartBloc>().add(AddToCart(
                        id: '${widget.product!.data!.id}',
                        quant: quantityController.text,
                        token: '${user!.data.accessToken}'));
                  },
                  child: Text('BUY NOW'),
                  style: ElevatedButton.styleFrom(
                      onPrimary: AppColors().White,
                      primary: AppColors().RedTextColor));
            })),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child:
                  BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return ElevatedButton(
                    onPressed: () async {
                      await ratingDialog(
                          context: context,
                          img: '${image![0].image}',
                          title: '${widget.product!.data!.name}');

                      context.read<CartBloc>().add(RateEvent(
                          product_id: '${widget.product!.data!.id}',
                          rating: rating));
                    },
                    child: Text('RATE'),
                    style: ElevatedButton.styleFrom(
                        onPrimary: AppColors().White,
                        primary: AppColors().RedTextColor));
              }),
            )
          ],
        ));
  }

  Future<void> PopUpDialog(
    BuildContext context,
    String? img,
    String? title,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15),
                  height: 420,
                  width: ScreenUtil().screenWidth * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(title!,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'GOTHAM',
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      Image.network(img!, height: 200, width: 200),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Enter Qty',
                          style: TextStyle(
                              fontFamily: 'GOTHAM',
                              fontSize: 18,
                              fontWeight: FontWeight.w200)),
                      SizedBox(height: 8),
                      Container(
                        width: 100,
                        child: Material(
                          child: TextField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 2),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('SUBMIT'),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors().RedTextColor,
                              onPrimary: AppColors().White,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontFamily: 'Gotham'),
                              minimumSize: Size(600.h, 142.h),
                              maximumSize: Size(600.h, 142.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.h))))
                    ],
                  )));
        });
  }

  Future<void> ratingDialog({
    BuildContext? context,
    String? img,
    String? title,
  }) async {
    return showDialog(
        context: context!,
        builder: (context) {
          return Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15),
                  height: 420,
                  width: ScreenUtil().screenWidth * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(title!,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'GOTHAM',
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      Image.network(img!, height: 200, width: 200),
                      SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                          initialRating: rating!,
                          itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              this.rating = rating;
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('RATE NOW'),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors().RedTextColor,
                              onPrimary: AppColors().White,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontFamily: 'Gotham'),
                              minimumSize: Size(600.h, 142.h),
                              maximumSize: Size(600.h, 142.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.h))))
                    ],
                  )));
        });
  }
}
