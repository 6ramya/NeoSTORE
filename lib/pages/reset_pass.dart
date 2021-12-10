import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:neostore/bloc/account_bloc.dart';
import 'package:neostore/bloc/account_state.dart';
import 'package:neostore/bloc/reset_password_bloc.dart';
import 'package:neostore/bloc/reset_password_event.dart';
import 'package:neostore/bloc/reset_password_state.dart';
import 'package:neostore/shared_preference/user_shared_preference.dart';

import 'package:neostore/model/colors.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/pages/login_page.dart';
import 'package:neostore/repository/user_repository.dart';

import 'package:neostore/widgets/text.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  String? userId;
  ResetPassword({Key? key, this.userId}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController PasswordController = TextEditingController();
  TextEditingController NewPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode passwordfocusNode = new FocusNode();
  FocusNode newPasswordfocusNode = new FocusNode();
  FocusNode confirmPasswordfocusNode = new FocusNode();
  late final _formKey;
  User? user;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    user = UserPreferences.getUser(widget.userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _padding1 = EdgeInsets.only(bottom: 30.h / 3);

    Widget buildTextBox(
        {required String text,
        required TextEditingController controller,
        required FocusNode focusNode,
        required IconData icon,
        required String? Validation(dynamic? value),
        required Function? onChanged(dynamic value)}) {
      return Container(
        height: 150.sp,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            hintText: text,
            hintStyle: TextStyle(
                color: focusNode.hasFocus ? Colors.white : Colors.transparent,
                fontWeight: FontWeight.w500),
            labelText: text,
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          validator: (value) => Validation(value),
          onChanged: (value) => onChanged(value),
        ),
      );
    }

    Widget Password() {
      return BlocBuilder<ResetPasswordBloc, resetPasswordState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'Password',
            controller: PasswordController,
            focusNode: passwordfocusNode,
            icon: Icons.lock_outline,
            Validation: (value) {
              if (value == null ||
                  !RegExp(r'^(?=.*[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)) {
                return 'Password must contain atleast 8 characters';
              } else {
                return null;
              }
            },
            onChanged: (value) => () {
                  context
                      .read<ResetPasswordBloc>()
                      .add(passwordChanged(password: value));
                });
      });
    }

    Widget NewPassword() {
      return BlocBuilder<ResetPasswordBloc, resetPasswordState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'New Password',
            controller: NewPasswordController,
            focusNode: newPasswordfocusNode,
            icon: Icons.lock_open,
            Validation: (value) {
              if (value == null ||
                  !RegExp(r'^(?=.*[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)) {
                return 'Password must contain atleast 8 characters';
              } else {
                return null;
              }
            },
            onChanged: (value) => () {
                  context
                      .read<ResetPasswordBloc>()
                      .add(setNewPassword(newPassword: value));
                });
      });
    }

    Widget ConfirmPassword() {
      return BlocBuilder<ResetPasswordBloc, resetPasswordState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'Confirm Password',
            controller: confirmPasswordController,
            focusNode: confirmPasswordfocusNode,
            icon: Icons.lock_outline,
            Validation: (value) {
              if (value == null || value != NewPasswordController.text) {
                return 'Password does not match';
              } else {
                return null;
              }
            },
            onChanged: (value) => () {
                  context
                      .read<ResetPasswordBloc>()
                      .add(confirmNewPassword(confirmPassword: value));
                });
      });
    }

    Widget ResetPasswordButton() {
      return BlocBuilder<ResetPasswordBloc, resetPasswordState>(
          builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              context.read<ResetPasswordBloc>().add(resetPassword(
                  token: '${user!.data.accessToken}',
                  password: PasswordController.text,
                  newPassword: NewPasswordController.text,
                  confirmPassword: confirmPasswordController.text));

              Navigator.pop(context);
            }
          },
          child: Text('RESET PASSWORD'),
          style: Theme.of(context).elevatedButtonTheme.style,
        );
      });
    }

    Widget resetPasswordForm() {
      return BlocProvider(
        create: (context) =>
            ResetPasswordBloc(authRepo: context.read<UserRepository>()),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TitleText(),
              Padding(padding: EdgeInsets.only(top: 148.h / 3)),
              Password(),
              Padding(padding: EdgeInsets.only(bottom: 100.h / 3)),
              NewPassword(),
              Padding(padding: EdgeInsets.only(bottom: 100.h / 3)),
              ConfirmPassword(),
              Padding(
                padding: EdgeInsets.only(bottom: 100.h / 3),
              ),
              ResetPasswordButton(),
            ],
          ),
        ),
      );
    }

    return ScreenUtilInit(
      builder: () {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors().DarkRed,
            title: Text('Reset Password',
                style: TextStyle(fontWeight: FontWeight.w500)),
            centerTitle: true,
          ),
          body: Container(
            height: ScreenUtil().screenHeight,
            padding: EdgeInsets.symmetric(
              horizontal: 100.h / 3,
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_img.jpg'),
                    fit: BoxFit.cover)),
            child: resetPasswordForm(),
          ),
        );
      },
      designSize: Size(1080, 1920),
    );
  }
}
