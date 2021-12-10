import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/cart_bloc.dart';

import 'package:neostore/repository/order_repository.dart';
import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/order_detail.dart';
import 'package:neostore/model/order_list.dart';
import 'package:neostore/pages/account_page.dart';
import 'package:neostore/pages/add_address.dart';
import 'package:neostore/pages/address_list.dart';
import 'package:neostore/pages/cart_page.dart';
import 'package:neostore/pages/edit_account_details.dart';
import 'package:neostore/pages/forgot_pass.dart';
import 'package:neostore/pages/home_screen.dart';
import 'package:neostore/pages/order_detail.dart';
import 'package:neostore/pages/orders.dart';
import 'package:neostore/pages/product_detailed.dart';
import 'package:neostore/pages/product_listing.dart';
import 'package:neostore/pages/register.dart';
import 'package:neostore/pages/reset_pass.dart';
import 'package:neostore/pages/store_locator.dart';
import 'package:neostore/repository/cart_repository.dart';
import 'package:neostore/repository/product_repository.dart';
import 'package:neostore/repository/user_repository.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/register':
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
            create: (context) => UserRepository(),
            child: Register(),
          );
        });

      case '/forgotPass':
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
              create: (context) => UserRepository(), child: ForgotPassword());
        });
      case '/resetPassword':
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
              create: (context) => UserRepository(),
              child: ResetPassword(userId: args.userId));
        });
      case '/editProfile':
        final args = settings.arguments as EditProfileArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
            create: (context) => UserRepository(),
            child: EditDetails(
              accountInfo: args.accountInfo,
              userId: args.userId,
            ),
          );
        });
      case '/myAccount':
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
            create: (context) => UserRepository(),
            child: AccountPage(
              userId: args.userId,
            ),
          );
        });
      case '/home':
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
            create: (context) => ProductRepository(),
            child: HomeScreen(
              userId: args.userId,
            ),
          );
        });
      case '/products':
        final args = settings.arguments as ProductListArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
            create: (context) => ProductRepository(),
            child: ProductListing(
              product: args.product,
              title: args.title,
              userId: args.userId,
            ),
          );
        });

      case '/productDetail':
        final args = settings.arguments as ProductDetailArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
            create: (context) => CartRepository(),
            child: ProductDetailed(
              product: args.product,
              title: args.title,
              userId: args.userId,
            ),
          );
        });
      case '/myCart':
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
            create: (context) => CartRepository(),
            child: MyCartPage(
              userId: args.userId,
            ),
          );
        });

      case '/saveAddress':
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(
            builder: (context) => Address(
                  userId: args.userId,
                ));
      case '/addressList':
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
              create: (context) => OrderRepository(),
              child: AddressList(userId: args.userId));
        });
      case '/orders':
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
              create: (context) => OrderRepository(),
              child: OrdersPage(userId: args.userId));
        });
      case '/orderDetail':
        final args = settings.arguments as OrderDetailArguments;

        return MaterialPageRoute(builder: (context) {
          return RepositoryProvider(
              create: (context) => OrderRepository(),
              child: OrderDetailPage(
                userId: args.userId,
                orderId: args.orderId,
              ));
        });
      case '/storeLocator':
        return MaterialPageRoute(builder: (context) => StoreLocator());
    }
  }
}
