import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return ScreenUtilInit(
      builder: () {
        return Text(
          'NeoSTORE',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 135.sp),
        );
      },
      designSize: Size(1080, 1920),
    );
  }
}
