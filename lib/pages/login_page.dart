import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:neostore/bloc/login_bloc.dart';
import 'package:neostore/bloc/login_event.dart';
import 'package:neostore/bloc/login_state.dart';
import 'package:neostore/bloc/form_status.dart';

import 'package:neostore/model/arguments.dart';

import 'package:neostore/model/user.dart';
import 'package:neostore/pages/forgot_pass.dart';
import 'package:neostore/pages/home_screen.dart';
import 'package:neostore/pages/product_detailed.dart';
import 'package:neostore/pages/product_listing.dart';
import 'package:neostore/pages/register.dart';
import 'package:neostore/pages/reset_pass.dart';
import 'package:neostore/repository/user_repository.dart';
import 'package:neostore/widgets/text.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? id;

  TextEditingController PasswordController = TextEditingController();
  TextEditingController UserNameController = TextEditingController();
  FocusNode usernamefocusNode = new FocusNode();
  FocusNode passwordfocusNode = new FocusNode();
  late final _formKey;

  final _padding1 = EdgeInsets.only(bottom: 60.h / 3);

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget forgotPassword = TextButton(
        onPressed: () {
          PasswordController.clear();

          Navigator.pushNamed(context, '/forgotPass');
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 54.sp,
            fontWeight: FontWeight.w500,
          ),
        ));

    Widget register = TextButton(
        onPressed: () {},
        child: Text(
          "DON'T HAVE AN ACCOUNT?",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 48.sp),
        ));
    Widget email() {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return TextFormField(
            controller: UserNameController,
            focusNode: usernamefocusNode,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                  color: usernamefocusNode.hasFocus
                      ? Colors.white
                      : Colors.transparent,
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
            onChanged: (value) => () {
                  context
                      .read<LoginBloc>()
                      .add(LoginUserNameChanged(username: value));
                });
      });
    }

    Widget password() {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return TextFormField(
          controller: PasswordController,
          focusNode: passwordfocusNode,
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(
              Icons.lock_open,
              color: Colors.white,
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
                color: passwordfocusNode.hasFocus
                    ? Colors.white
                    : Colors.transparent,
                fontWeight: FontWeight.w500),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            labelText: 'Password',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(color: Colors.white)),
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
                !RegExp(r'^(?=.*[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)) {
              return 'Password must contain atleast 8 characters';
            } else {
              return null;
            }
          },
        );
      });
    }

    Widget loginButton(String text) {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(FormSubmitted(
                        username: UserNameController.text,
                        password: PasswordController.text));

                    if (state.formStatus is SubmissionSuccess) {
                      Navigator.pushReplacementNamed(context, '/home',
                          arguments: HomeScreenArguments(userId: id));
                    }
                  }
                },
                child: Text(
                  text,
                ),
                style: Theme.of(context).elevatedButtonTheme.style,
              );
      });
    }

    Widget loginForm() {
      return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            id = state.id;
            final formStatuss = state.formStatus;
            if (formStatuss is SubmissionFailed) {
              Fluttertoast.showToast(
                  msg: "${formStatuss.exception.toString()}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.red,
                  fontSize: 12.0);
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleText(),
                Padding(padding: EdgeInsets.only(top: 148.h / 3)),
                email(),
                Padding(
                  padding: _padding1,
                ),
                password(),
                Padding(
                  padding: EdgeInsets.only(bottom: 100.h / 3),
                ),
                loginButton('LOGIN'),
                Padding(
                  padding: EdgeInsets.only(bottom: 65.h / 3),
                ),
                forgotPassword,
              ],
            ),
          ));
    }

    return ScreenUtilInit(
        designSize: Size(1080, 1920),
        builder: () {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              height: ScreenUtil().screenHeight,
              padding: EdgeInsets.symmetric(
                  horizontal: 100.h / 3, vertical: 100.h / 3),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_img.jpg'),
                      fit: BoxFit.cover)),
              child: BlocProvider(
                create: (context) => LoginBloc(
                  authRepo: context.read<UserRepository>(),
                ),
                child: loginForm(),
              ),
            ),
            floatingActionButton: Row(
              children: [
                Expanded(child: register),
                Container(
                  height: 138.h,
                  width: 138.h,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    elevation: 0,
                    backgroundColor: Colors.red[700],
                    child: Icon(
                      Icons.add,
                    ),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
