import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:neostore/bloc/order_bloc.dart';
import 'package:neostore/bloc/order_event.dart';
import 'package:neostore/bloc/order_state.dart';
import 'package:neostore/repository/order_repository.dart';
import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/colors.dart';
import 'package:neostore/model/order_detail.dart';
import 'package:neostore/model/user.dart';
import 'package:provider/src/provider.dart';

class OrderDetailPage extends StatefulWidget {
  String? userId;
  int? orderId;
  OrderDetailPage({Key? key, this.userId, this.orderId}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetailPage> {
  late OrderBloc orderBloc;
  User? user;

  @override
  void initState() {
    user = UserPreferences.getUser(widget.userId!);

    orderBloc = OrderBloc(authRepo: context.read<OrderRepository>());
    orderBloc.add(getOrderDetail(
        token: '${user!.data.accessToken}', orderId: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => BlocProvider(
              create: (context) => orderBloc,
              child: Scaffold(
                  appBar: AppBar(
                    title: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'GOTHAM',
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            children: [
                          TextSpan(text: 'Order ID:'),
                          TextSpan(
                              text: '${widget.orderId}',
                              style: TextStyle(
                                  fontFamily: 'GOTHAM',
                                  fontWeight: FontWeight.w100))
                        ])),
                    backgroundColor: AppColors().DarkRed,
                    centerTitle: true,
                    actions: [Icon(Icons.search)],
                    elevation: 0,
                  ),
                  body: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                    return state is OrderDetailLoaded
                        ? Column(
                            children: [
                              buildList(data: state.orderDetail!.data),
                              Divider(color: Colors.grey[600]),
                              Padding(
                                padding: const EdgeInsets.all(34.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: TextStyle(
                                          fontFamily: 'GOTHAM',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text('Rs ${state.orderDetail!.data!.cost}'),
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey[600]),
                              Padding(padding: EdgeInsets.only(bottom: 20)),
                            ],
                          )
                        : CircularProgressIndicator();
                  })),
            ));
  }

  Widget buildList({OrderDetailData? data}) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(color: Colors.grey[600]),
        itemCount: data!.order_details!.length,
        itemBuilder: (context, index) {
          return buildItem(orderDetails: data.order_details![index]);
        });
  }

  Widget buildItem({OrderDetails? orderDetails}) {
    return ListTile(
      leading: Image.network('${orderDetails!.prod_image}'),
      title: Text('${orderDetails.prod_name}',
          style: TextStyle(fontFamily: 'GOTHAM', fontWeight: FontWeight.w400)),
      subtitle: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text('(${orderDetails.prod_cat_name})')),
          Padding(
            padding: EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'QTY : ${orderDetails.quantity}',
                  style: TextStyle(color: Colors.black),
                ),
                Text('Rs ${orderDetails.total}',
                    style: TextStyle(color: Colors.black))
              ],
            ),
          )
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}
