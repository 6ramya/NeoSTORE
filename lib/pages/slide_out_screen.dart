import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:neostore/bloc/account_bloc.dart';
import 'package:neostore/bloc/account_event.dart';
import 'package:neostore/bloc/homescreen_bloc.dart';
import 'package:neostore/bloc/homescreen_event.dart';
import 'package:neostore/bloc/homescreen_state.dart';
import 'package:neostore/bloc/product_bloc.dart';
import 'package:neostore/bloc/product_state.dart';
import 'package:neostore/repository/user_repository.dart';

import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/colors.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/pages/account_page.dart';
import 'package:neostore/pages/login_page.dart';
import 'package:neostore/pages/store_locator.dart';
import 'package:neostore/repository/product_repository.dart';

class SlideOutDrawer extends StatefulWidget {
  String? userId;
  SlideOutDrawer({this.userId});

  @override
  State<SlideOutDrawer> createState() => _SlideOutDrawerState();
}

class _SlideOutDrawerState extends State<SlideOutDrawer> {
  int? total_carts;
  String? imagePath;
  User? user;
  late AccountBloc accountBloc;
  @override
  void initState() {
    user = UserPreferences.getUser(widget.userId!);
    accountBloc = AccountBloc(authRepo: context.read<UserRepository>());
    accountBloc.add(fetchAccountDetails(token: '${user!.data.accessToken}'));

    total_carts = UserPreferences.getCartItems();
    imagePath = UserPreferences.getProfilePicture();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> id = {
      'tables': '1',
      'sofas': '3',
      'chairs': '2',
      'cupboards': '4'
    };
    return ScreenUtilInit(builder: () {
      // return Scaffold(
      return BlocProvider(
        create: (context) =>
            HomeBloc(authRepo: context.read<ProductRepository>()),
        child: Drawer(
          child: Container(
              color: AppColors().MediumBlack,
              child: ListView(children: [
                buildProfile(context),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                buildCartItem(context,
                    icon: Icon(Icons.shopping_cart,
                        color: Colors.white, size: 84.h / 3),
                    name: 'My Cart', onTap: () {
                  Navigator.pushNamed(context, '/myCart',
                      arguments: HomeScreenArguments(userId: widget.userId));
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                  int? cid = state.product!.data![0].productCategoryId;
                  String? title1;
                  switch (cid) {
                    case 1:
                      title1 = 'Tables';
                      break;
                    case 2:
                      title1 = 'Chairs';
                      break;
                    case 3:
                      title1 = 'Sofas';
                      break;
                    case 4:
                      title1 = 'Cupboards';
                      break;
                  }

                  if (state.product != null) {
                    Navigator.pushNamed(context, '/products',
                        arguments: ProductListArguments(
                            product: state.product,
                            title: title1,
                            userId: widget.userId));
                  }
                }, builder: (context, state) {
                  return buildItem(context,
                      icon: Icon(MdiIcons.tableChair,
                          color: Colors.white, size: 84.h / 3),
                      name: 'Tables', onTap: () {
                    context.read<HomeBloc>().add(ButtonClicked(id: '1'));
                  });
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return buildItem(context,
                      icon: Icon(Icons.chair,
                          color: Colors.white, size: 84.h / 3),
                      name: 'Sofas', onTap: () {
                    context.read<HomeBloc>().add(ButtonClicked(id: '3'));
                  });
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return buildItem(context,
                      icon: Icon(MdiIcons.chairRolling,
                          color: Colors.white, size: 84.h / 3),
                      name: 'Chairs', onTap: () {
                    context.read<HomeBloc>().add(ButtonClicked(id: '2'));
                    if (state.product != null) {}
                  });
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return buildItem(context,
                      icon: Icon(MdiIcons.cupboard,
                          color: Colors.white, size: 84.h / 3),
                      name: 'Cupboards', onTap: () {
                    context.read<HomeBloc>().add(ButtonClicked(id: '4'));
                  });
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                buildItem(context,
                    icon:
                        Icon(Icons.person, color: Colors.white, size: 84.h / 3),
                    name: 'My Account', onTap: () {
                  Navigator.pushNamed(context, '/myAccount',
                      arguments: HomeScreenArguments(userId: widget.userId));
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                buildItem(context,
                    icon: Icon(MdiIcons.mapMarkerRadius,
                        color: Colors.white, size: 84.h / 3),
                    name: 'Store Locator', onTap: () {
                  Navigator.pushNamed(context, '/storeLocator');
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                buildItem(context,
                    icon: Icon(MdiIcons.scriptText,
                        color: Colors.white, size: 84.h / 3),
                    name: 'My Orders', onTap: () {
                  Navigator.pushNamed(context, '/orders',
                      arguments: HomeScreenArguments(userId: widget.userId));
                }),
                Divider(
                  thickness: 1,
                  color: AppColors().DarkGrey,
                ),
                buildItem(context,
                    icon:
                        Icon(Icons.logout, color: Colors.white, size: 84.h / 3),
                    name: 'Logout', onTap: () async {
                  await UserPreferences.removeTotalCart();
                  await UserPreferences.removeAddress();
                  await UserPreferences.removeAddressList();
                  await UserPreferences.removeProfilePic();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                })
              ])),
        ),
      );
    });
  }

  Widget buildProfile(BuildContext context) {
    return Column(children: [
      SizedBox(height: 107.h / 3),
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 46,
          backgroundImage: NetworkImage(imagePath == null
              ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
              : imagePath!),
        ),
      ),
      SizedBox(height: 54.h / 3),
      Text('${user!.data.firstName} ${user!.data.lastName}',
          style: TextStyle(
              fontSize: 69.sp / 3,
              fontWeight: FontWeight.w500,
              color: AppColors().White)),
      SizedBox(height: 40.h / 3),
      Text('${user!.data.email}',
          style: TextStyle(
              fontSize: 39.sp / 3,
              fontWeight: FontWeight.w200,
              color: AppColors().White)),
      SizedBox(height: 40.h / 3),
    ]);
  }

  Widget buildCartItem(BuildContext context,
      {required Icon icon, required String name, VoidCallback? onTap}) {
    return Material(
      color: AppColors().MediumBlack,
      child: ListTile(
        onTap: () => onTap!(),
        leading: icon,
        title: Text(
          name,
          style: TextStyle(
              color: Colors.white,
              fontSize: 48.h / 3,
              fontWeight: FontWeight.w500),
        ),
        trailing: Container(
          height: 78.h / 3,
          width: 78.h / 3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors().Red,
          ),
          child: Center(
            child: Text(
              total_carts == null ? '0' : '$total_carts',
              style: TextStyle(color: AppColors().White),
            ),
          ),
        ),
        hoverColor: AppColors().DarkGrey,
        focusColor: AppColors().White,
        selectedTileColor: AppColors().DarkGrey,
      ),
    );
  }

  Widget buildItem(BuildContext context,
      {required Icon icon, required String name, VoidCallback? onTap}) {
    return Material(
      color: AppColors().MediumBlack,
      child: ListTile(
        onTap: () => onTap!(),
        leading: icon,
        title: Text(
          name,
          style: TextStyle(
              color: Colors.white,
              fontSize: 48.h / 3,
              fontWeight: FontWeight.w500),
        ),
        hoverColor: AppColors().DarkGrey,
        focusColor: AppColors().White,
        selectedTileColor: AppColors().DarkGrey,
      ),
    );
  }
}
