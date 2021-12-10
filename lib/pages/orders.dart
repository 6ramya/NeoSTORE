import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:neostore/bloc/order_bloc.dart';
import 'package:neostore/bloc/order_event.dart';
import 'package:neostore/bloc/order_state.dart';
import 'package:neostore/repository/order_repository.dart';
import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/colors.dart';
import 'package:http/http.dart' as http;

import 'package:neostore/model/order.dart';
import 'package:neostore/model/order_detail.dart';

import 'package:neostore/model/order_list.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/pages/order_detail.dart';

class OrdersPage extends StatefulWidget {
  String? userId;
  OrdersPage({Key? key, this.userId}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<OrdersPage> {
  late OrderBloc orderBloc;
  // OrderList? order;
  User? user;
  @override
  void initState() {
    user = UserPreferences.getUser(widget.userId!);
    orderBloc = OrderBloc(authRepo: context.read<OrderRepository>());
    orderBloc.add(getOrderList(token: user!.data.accessToken));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => BlocProvider(
              create: (context) => orderBloc,
              child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: AppColors().DarkRed,
                    title: const Text('My Orders',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    centerTitle: true,
                    actions: [Icon(Icons.search)],
                  ),
                  body: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                    return state is OrderListLoaded
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  
                                  Navigator.pushNamed(context, '/orderDetail',
                                      arguments: OrderDetailArguments(
                                          userId: widget.userId,
                                          orderId:
                                              state.order!.data![index].id));
                                },
                                title: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order ID: ${state.order!.data![index].id}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GOTHAM'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Ordered Date: ${state.order!.data![index].created}',
                                            style:
                                                TextStyle(fontFamily: 'GOTHAM'),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Rs ${state.order!.data![index].cost}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'GOTHAM'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Divider(color: Colors.black),
                            itemCount: state.order!.data!.length)
                        : Center(child: CircularProgressIndicator());
                  })),
            ));
  }
}
