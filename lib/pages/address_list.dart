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

import 'package:neostore/model/order.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/pages/add_address.dart';
import 'package:http/http.dart' as http;
import 'package:neostore/pages/orders.dart';

class AddressList extends StatefulWidget {
  String? userId;
  AddressList({Key? key, this.userId}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  late List<String?> address;
  String? shippingAddress;
  
  int? _selectedValue = 0;
  User? user;
 
  @override
  void initState() {
    address = UserPreferences.getAddressList();
    user = UserPreferences.getUser(widget.userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => BlocProvider(
        create: (context) =>
            OrderBloc(authRepo: context.read<OrderRepository>()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppColors().DarkRed,
            title: Text(
              'Address List',
              style:
                  TextStyle(fontFamily: 'GOTHAM', fontWeight: FontWeight.w500),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Address(
                                  userId: widget.userId,
                                )));
                  },
                  icon: Icon(Icons.add))
            ],
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: address.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                       
                        leading: Radio<int?>(
                            value: index,
                            activeColor: Colors.grey,
                            focusColor: Colors.white,
                            groupValue: _selectedValue,
                            onChanged: (value) async {
                              setState(() {
                                this._selectedValue = value;
                              });
                              await UserPreferences.setAddress(address[index]);
                            }),
                        title: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          height: 90,
                          width: 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${user!.data.firstName} ${user!.data.lastName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'GOTHAM'),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await UserPreferences.deleteAddress(
                                              address[index]);
                                          setState(() {
                                            address = UserPreferences
                                                .getAddressList();
                                          });
                                        },
                                        icon: Icon(Icons.close,
                                            color: Colors.grey, size: 18))
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('${address[index]}'))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      shippingAddress = UserPreferences.getAddress();
                    
                      context.read<OrderBloc>().add(placeOrder(
                          token: user!.data.accessToken,
                          address: shippingAddress));

                    
                      Navigator.pushNamed(context, '/orders',
                          arguments: HomeScreenArguments(
                            userId: widget.userId,
                          ));
                    },
                    child: Text('PLACE ORDER'),
                    style: ElevatedButton.styleFrom(
                      onPrimary: AppColors().White,
                      primary: AppColors().RedTextColor,
                      minimumSize: Size(880.h, 142.h),
                      maximumSize: Size(880.h, 142.h),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
      designSize: Size(1080, 1920),
    );
  }
}
