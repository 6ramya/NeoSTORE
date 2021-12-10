import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/colors.dart';

class Address extends StatefulWidget {
  String? userId;
  Address({Key? key, this.userId}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors().DarkRed,
          title: Text(
            'Add Address',
            style: TextStyle(fontFamily: 'GOTHAM', fontWeight: FontWeight.w500),
          ),
          actions: [Icon(Icons.search)],
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Colors.grey[350],
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 90.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ADDRESS',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontFamily: 'GOTHAM',
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h, bottom: 80.h),
                      child: Container(
                        color: Colors.white,
                        height: 280.h,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: address,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12)),
                        ),
                      ),
                    ),
                    Text(
                      'CITY',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontFamily: 'GOTHAM',
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h, bottom: 80.h),
                      child: Container(
                        color: Colors.white,
                        height: 150.h,
                        child: TextField(
                          controller: city,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12)),
                        ),
                      ),
                    ),
                    Row(
                     
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
               
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'CITY',
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontFamily: 'GOTHAM',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40.h, bottom: 80.h),
                              child: Container(
                                color: Colors.white,
                                width: ScreenUtil().screenWidth * 0.44,
                                height: 130.h,
                                child: TextField(
                                  controller: city,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ),
                            Text(
                              'ZIP CODE',
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  fontFamily: 'GOTHAM',
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40.h, bottom: 80.h),
                              child: Container(
                                color: Colors.white,
                                width: ScreenUtil().screenWidth * 0.44,
                                height: 130.h,
                                child: TextField(
                                  controller: zipcode,
                                  keyboardType: TextInputType.number,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STATE',
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  fontFamily: 'GOTHAM',
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40.h, bottom: 80.h),
                              child: Container(
                                color: Colors.white,
                                width: ScreenUtil().screenWidth * 0.44,
                                height: 130.h,
                                child: TextField(
                                  controller: state,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ),
                            Text(
                              'COUNTRY',
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  fontFamily: 'GOTHAM',
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40.h, bottom: 80.h),
                              child: Container(
                                color: Colors.white,
                                width: ScreenUtil().screenWidth * 0.44,
                                height: 130.h,
                                child: TextField(
                                  controller: country,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await UserPreferences.setAddressList(
                            '${address.text},${city.text}-${zipcode.text},${state.text},${country.text}');
                        Navigator.pushNamed(context, '/addressList',
                            arguments:
                                HomeScreenArguments(userId: widget.userId));
                      },
                      child: Text('SAVE ADDRESS'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: AppColors().White,
                        primary: AppColors().RedTextColor,
                        minimumSize: Size(960.h, 142.h),
                        maximumSize: Size(960.h, 142.h),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
      designSize: Size(1080, 1920),
    );
  }
}
