import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:neostore/shared_preference/user_shared_preference.dart';

import 'package:neostore/model/colors.dart';
import 'package:neostore/pages/add_address.dart';
import 'package:neostore/pages/address_list.dart';
import 'package:neostore/pages/cart_page.dart';

import 'package:neostore/pages/home_screen.dart';
import 'package:neostore/pages/login_page.dart';
import 'package:neostore/pages/order_detail.dart';
import 'package:neostore/pages/product_detailed.dart';
import 'package:neostore/pages/product_listing.dart';
import 'package:neostore/pages/register.dart';
import 'package:neostore/pages/reset_pass.dart';
import 'package:neostore/repository/user_repository.dart';
import 'package:neostore/route_generator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          title: 'NeoSTORE',
          theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'Gotham',
            textTheme: TextTheme(
              headline1: TextStyle(color: Colors.white),
              headline2: TextStyle(color: Colors.white),
              headline3: TextStyle(color: Colors.white),
              headline4: TextStyle(color: Colors.white),
              headline5: TextStyle(color: Colors.white),
              headline6: TextStyle(color: Colors.white),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    primary: AppColors().White,
                    onPrimary: AppColors().RedTextColor,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: 'Gotham'),
                    minimumSize: Size(880.h, 142.h),
                    maximumSize: Size(880.h, 142.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.h)))),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: TextStyle(
                      color: AppColors().RedTextColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham'),
                  primary: Colors.white),
            ),
            errorColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => RepositoryProvider(
                create: (context) => UserRepository(), child: LoginPage()),
          },
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
      designSize: Size(1080, 1920),
    );
  }
}
