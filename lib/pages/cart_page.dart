import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:neostore/bloc/cart_bloc.dart';

import 'package:neostore/bloc/cart_state.dart';

import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/bloc/cart_event.dart';
import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/cart.dart';

import 'package:http/http.dart' as http;
import 'package:neostore/model/colors.dart';

import 'package:neostore/model/list_cart_items.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/repository/cart_repository.dart';
import 'package:neostore/widgets/dropdownbutton.dart';

class MyCartPage extends StatefulWidget {
  String? userId;
  MyCartPage({Key? key, this.userId}) : super(key: key);
  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final items = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  User? user;
  late CartBloc cartBloc;

  @override
  void initState() {
    user = UserPreferences.getUser('${widget.userId}');
    cartBloc = CartBloc(authRepo: context.read<CartRepository>());
    cartBloc.add(LoadItems(token: '${user!.data.accessToken}'));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cartBloc.add(LoadItems(token: '${user!.data.accessToken}'));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => BlocProvider(
              create: (context) => cartBloc,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text('My Cart'),
                    backgroundColor: AppColors().DarkRed,
                    centerTitle: true,
                    actions: [Icon(Icons.search)],
                  ),
                  body: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                    return state is CartLoaded
                        ? state.cartItems!.data != null
                            ? Column(
                                children: [
                                  Expanded(
                                      child: buildList(items: state.cartItems)),
                                  Divider(color: Colors.grey[600]),
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
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
                                        Text('Rs ${state.cartItems!.total}'),
                                      ],
                                    ),
                                  ),
                                  Divider(color: Colors.grey[600]),
                                  Padding(padding: EdgeInsets.only(bottom: 20)),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/addressList',
                                          arguments: HomeScreenArguments(
                                              userId: widget.userId));
                                    },
                                    child: const Text('ORDER NOW'),
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColors().RedTextColor,
                                        onPrimary: AppColors().White,
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            fontFamily: 'Gotham'),
                                        minimumSize: Size(300, 60),
                                        maximumSize: Size(300, 80),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10)),
                                ],
                              )
                            : Center(
                                child: Text('${state.cartItems!.message}!!'))
                        : Center(child: CircularProgressIndicator());
                  })),
            ));
  }

  Widget buildList({CartItems? items}) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Colors.grey[600]),
        itemCount: items!.data!.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (_) async {
              context.read<CartBloc>().add(DeleteCart(
                  product_id: items.data![index].product_id,
                  token: '${user!.data.accessToken}'));

              setState(() {
                items.data!.removeAt(index);
              });

              context
                  .read<CartBloc>()
                  .add(LoadItems(token: '${user!.data.accessToken}'));
             
            },
            child: buildItem(
              item: items.data![index],
              
            ),
            background: Container(
             
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                child: Icon(Icons.delete),
                backgroundColor: Colors.red,
                onPressed: () {},
                mini: true,
              ),
            ),
          );
        });
  }

  Widget buildItem({Data1? item}) {
    return ListTile(
      leading: Image.network('${item!.product!.product_images}'),

      // isThreeLine: true,
      title: Text('${item.product!.name}'),
      subtitle: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text('(${item.product!.product_category})')),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                   
                    height: 35,
                    width: 50,
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey[300],
                    ),
                    child: QuantityDropdownButton(
                        item: item, token: '${user!.data.accessToken}')),
                Text('Rs ${item.product!.sub_total}'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}
