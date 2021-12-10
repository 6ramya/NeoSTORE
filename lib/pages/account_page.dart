import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neostore/bloc/account_event.dart';
import 'package:neostore/bloc/account_state.dart';
import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/bloc/account_bloc.dart';
import 'package:neostore/bloc/account_event.dart';
import 'package:neostore/bloc/account_state.dart';
import 'package:neostore/model/account_details.dart';
import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/colors.dart';
import 'package:http/http.dart' as http;
import 'package:neostore/model/user.dart';
import 'package:neostore/pages/edit_account_details.dart';
import 'package:neostore/pages/reset_pass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neostore/repository/user_repository.dart';
import 'package:path_provider/path_provider.dart';

class AccountPage extends StatefulWidget {
  String? userId;
  AccountPage({Key? key, this.userId}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? imagePath;
  User? user;
  late AccountBloc accountBloc;
  @override
  void initState() {
    user = UserPreferences.getUser(widget.userId!);
    accountBloc = AccountBloc(authRepo: context.read<UserRepository>());
    accountBloc.add(fetchAccountDetails(token: '${user!.data.accessToken}'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors().DarkRed,
            title: Text('My Account',
                style: TextStyle(fontWeight: FontWeight.w500)),
            centerTitle: true,
            actions: [Icon(Icons.search)],
          ),
          body: Container(
            height: ScreenUtil().screenHeight,
            padding: EdgeInsets.symmetric(
                horizontal: 100.h / 3, vertical: 100.h / 3),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_img.jpg'),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
                child: BlocProvider(
                    create: (context) => accountBloc, child: buildForm())),
          ),
          bottomNavigationBar: resetPasswordButton()),
      designSize: Size(1080, 1920),
    );
  }

  Widget buildForm() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return state is AccountDetailsLoadedState
          ? displayAccountDetails(user: state.user)
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }

  Widget displayAccountDetails({AccountDetails? user}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 70.h),
        child: Column(
          children: [
            buildPicture(img: '${user!.data.userData.profile_pic}'),
            Padding(
              padding: EdgeInsets.only(top: 60.h, bottom: 40.h),
              child: buildTextField(
                  icon: Icons.person, text: '${user.data.userData.first_name}'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: buildTextField(
                  icon: Icons.person, text: '${user.data.userData.last_name}'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: buildTextField(
                  icon: Icons.mail, text: '${user.data.userData.email}'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: buildTextField(
                  icon: Icons.phone_android,
                  text: '${user.data.userData.phone_no}'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: buildTextField(
                  icon: Icons.cake, text: '${user.data.userData.dob}'),
            ),
            editProfileButton(details: user),
          ],
        ));
  }

  Widget buildTextField({IconData? icon, String? text}) {
    return TextField(
      focusNode: new AlwaysDisabledTextField(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget editProfileButton({AccountDetails? details}) {
    return ElevatedButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/editProfile',
              arguments: EditProfileArguments(
                  accountInfo: details, userId: widget.userId));
        },
        child: Text(
          'EDIT PROFILE',
        ),
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
                borderRadius: BorderRadius.circular(20.h))));
  }

  Widget buildPicture({required String img}) {
    final imagePath = Uri.parse(img);
    final image = img.isEmpty || img.contains('null')
        ? NetworkImage(
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
        : NetworkImage(img);

    return ClipOval(
        child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        width: 128,
        height: 128,
      ),
    ));
  }

  Widget resetPasswordButton() {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: 50,
      child: TextButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/resetPassword',
              arguments: HomeScreenArguments(userId: widget.userId));
        },
        child: Text(
          'RESET PASSWORD',
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary: Colors.grey,
          backgroundColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 20, fontFamily: 'GOTHAM', fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class AlwaysDisabledTextField extends FocusNode {
  @override
  bool get hasFocus => false;
}
