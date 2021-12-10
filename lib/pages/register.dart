import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:neostore/bloc/register_event.dart';
import 'package:neostore/bloc/register_state.dart';
import 'package:neostore/bloc/register_bloc.dart';
import 'package:neostore/bloc/form_status.dart';
import 'package:neostore/model/colors.dart';

import 'package:neostore/model/model.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/pages/login_page.dart';
import 'package:neostore/repository/user_repository.dart';
import 'package:neostore/widgets/checkbox.dart';
import 'package:neostore/widgets/text.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final _formKey;
  TextEditingController PasswordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhNumberController = TextEditingController();

  FocusNode lastnamefocusNode = new FocusNode();
  FocusNode emailfocusNode = new FocusNode();
  FocusNode passwordfocusNode = new FocusNode();
  FocusNode cPasswordfocusNode = new FocusNode();
  FocusNode phNofocusNode = new FocusNode();

  bool _checked = true;

  var selectedGender = null;
  Data? _data;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    FocusNode firstnamefocusNode = new FocusNode();

    final _padding = EdgeInsets.symmetric(horizontal: 100.sp, vertical: 100.sp);

    final _padding1 = EdgeInsets.only(bottom: 30.sp);

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
          obscureText:
              text == 'Password' || text == 'Confirm Password' ? true : false,
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

    Widget Firstname() {
      return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'First name',
            controller: FirstNameController,
            focusNode: firstnamefocusNode,
            icon: Icons.person,
            Validation: (value) {
              if (value == null || !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                return 'Provide correct name';
              } else {
                return null;
              }
            },
            onChanged: (value) => () {
                  context
                      .read<RegisterBloc>()
                      .add(FirstNameChanged(firstname: value));
                });
      });
    }

    Widget lastName() {
      return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'Last name',
            controller: LastNameController,
            focusNode: lastnamefocusNode,
            icon: Icons.person,
            Validation: (value) {
              if (value == null || !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                return 'Provide correct name';
              } else {
                return null;
              }
            },
            onChanged: (value) => () => context
                .read<RegisterBloc>()
                .add(LastNameChanged(lastname: value)));
      });
    }

    Widget email() {
      return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'Email',
            controller: EmailController,
            focusNode: emailfocusNode,
            icon: Icons.mail,
            Validation: (value) {
              if (value == null ||
                  !RegExp(r'^[\w-_\.]+@([\w-].)+[a-z]{2,5}').hasMatch(value)) {
                return 'Enter valid email Id';
              } else
                return null;
            },
            onChanged: (value) => () {
                  context
                      .read<RegisterBloc>()
                      .add(FirstNameChanged(firstname: value));
                });
      });
    }

    Widget Password() {
      return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'Password',
            controller: PasswordController,
            focusNode: passwordfocusNode,
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
                      .read<RegisterBloc>()
                      .add(PasswordChanged(password: value));
                });
      });
    }

    Widget ConfirmPassword() {
      return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'Confirm Password',
            controller: cPasswordController,
            focusNode: cPasswordfocusNode,
            icon: Icons.lock,
            Validation: (value) {
              if (value == null || value != PasswordController.text) {
                return 'Password does not match';
              } else {
                return null;
              }
            },
            onChanged: (value) => () {
                  context
                      .read<RegisterBloc>()
                      .add(ConfirmPasswordChanged(confirmPassword: value));
                });
      });
    }

    Widget phoneNumber() {
      return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
        return buildTextBox(
            text: 'Phone Number',
            controller: PhNumberController,
            focusNode: phNofocusNode,
            icon: Icons.phone_android,
            Validation: (value) {
              if (value == null || !RegExp(r'^\d{10}').hasMatch(value)) {
                return 'Provide correct phone number';
              } else
                return null;
            },
            onChanged: (value) => () {
                  context
                      .read<RegisterBloc>()
                      .add(PhoneNumberChanged(phNumber: value));
                });
      });
    }

    Widget GenderField() {
      return FormField<Gender>(
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Gender',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Radio<Gender>(
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      value: Gender.FEMALE,
                      groupValue: selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          selectedGender = newValue!;
                       
                        });
                      }),
                  Expanded(
                    child: Text(
                      'Female',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Radio<Gender>(
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      value: Gender.MALE,
                      groupValue: selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        
                        });
                      }),
                  Expanded(
                      child: Text(
                    'Male',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w500),
                  )),
                ],
              ),
              Text(
                state.errorText ?? '',
                style: TextStyle(color: Colors.white, fontSize: 11),
              )
            ],
          );
        },
        validator: (value) {
          if (selectedGender == null) {
            return 'Select Gender';
          } else {
            return null;
          }
        },
      );
    }

    Widget RegisterButton() {
      return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    
                    context.read<RegisterBloc>().add(RegistrationFormSubmitted(
                        firstname: FirstNameController.text,
                        lastname: LastNameController.text,
                        email: EmailController.text,
                        password: PasswordController.text,
                        confirmPassword: cPasswordController.text,
                        genderr: selectedGender.toString().substring(7),
                        phNumber: PhNumberController.text));

                    if (state.formStatus is SubmissionSuccess) {
                     
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('REGISTER'),
                style: Theme.of(context).elevatedButtonTheme.style,
              );
      });
    }

    Widget RegistrationForm() {
      return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
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
            Navigator.pop(
              context,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleText(),
              Padding(padding: EdgeInsets.only(top: 100.h)),
              Firstname(),
              Padding(padding: _padding1),
              lastName(),
              Padding(padding: _padding1),
              email(),
              Padding(padding: _padding1),
              Password(),
              Padding(padding: _padding1),
              ConfirmPassword(),
              Padding(padding: EdgeInsets.only(bottom: 30.h)),
              GenderField(),
              phoneNumber(),
              Padding(padding: _padding1),
              CheckBoxFormField(),
              Padding(
                padding: _padding1,
              ),
              RegisterButton(),
              Padding(
                padding:
                    EdgeInsets.only(bottom: 65 / (data.devicePixelRatio * 3)),
              ),
            ],
          ),
        ),
      );
    }

    return ScreenUtilInit(
      builder: () {
        return Scaffold(
          appBar: AppBar(
            title: Text('Register'),
            backgroundColor: AppColors().DarkRed,
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_img.jpg'),
                      fit: BoxFit.cover)),
              padding: _padding,
              child: BlocProvider(
                create: (context) => RegisterBloc(
                  authRepo: context.read<UserRepository>(),
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                            child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: RegistrationForm(),
                    ))),
                  ],
                ),
              )),
        );
      },
      designSize: Size(1080, 1920),
    );
  }
}
