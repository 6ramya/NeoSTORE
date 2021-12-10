import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:neostore/bloc/login_bloc.dart';
import 'package:neostore/bloc/login_event.dart';
import 'package:neostore/bloc/login_state.dart';

import 'package:neostore/model/user.dart';

import 'package:neostore/pages/home_screen.dart';
import 'package:neostore/pages/login_page.dart';
import 'package:neostore/pages/register.dart';
import 'package:neostore/pages/reset_pass.dart';
import 'package:neostore/repository/user_repository.dart';

import 'package:neostore/widgets/text.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailfocusNode = new FocusNode();
  late final _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget email() {
      return TextFormField(
        controller: emailController,
        focusNode: emailfocusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.white,
          ),
          hintText: 'Email',
          hintStyle: TextStyle(
              color:
                  emailfocusNode.hasFocus ? Colors.white : Colors.transparent,
              fontWeight: FontWeight.w500),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelText: 'Email',
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
        validator: (value) {
          if (value == null ||
              !RegExp(r'^[\w-_\.]+@([\w-].)+[a-z]{2,5}').hasMatch(value)) {
            return 'Enter valid email Id';
          } else
            return null;
        },
      );
    }

    Widget loginButton(String text) {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context
                  .read<LoginBloc>()
                  .add(ForgotPass(email: emailController.text));

              Navigator.pop(context);
            }
          },
          child: Text(
            text,
          ),
          style: Theme.of(context).elevatedButtonTheme.style,
        );
      });
    }

    return ScreenUtilInit(
        designSize: Size(1080, 1920),
        builder: () {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 100.h / 3, vertical: 100.h / 3),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_img.jpg'),
                      fit: BoxFit.cover)),
              child: Form(
                key: _formKey,
                child: BlocProvider(
                  create: (context) =>
                      LoginBloc(authRepo: context.read<UserRepository>()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TitleText(),
                      Padding(padding: EdgeInsets.only(top: 148.h / 3)),
                      email(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 180.h / 3),
                      ),
                      loginButton('LOGIN'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
