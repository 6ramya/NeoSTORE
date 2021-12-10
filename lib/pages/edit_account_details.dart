import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neostore/bloc/account_bloc.dart';
import 'package:neostore/bloc/account_event.dart';
import 'package:neostore/bloc/account_state.dart';
import 'package:neostore/bloc/register_event.dart';
import 'package:neostore/shared_preference/user_shared_preference.dart';
import 'package:neostore/model/account_details.dart';
import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/colors.dart';
import 'package:http/http.dart' as http;
import 'package:neostore/model/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neostore/repository/user_repository.dart';
import 'package:path_provider/path_provider.dart';

class EditDetails extends StatefulWidget {
  String? userId;
  AccountDetails? accountInfo;
  EditDetails({Key? key, this.accountInfo, this.userId}) : super(key: key);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  FocusNode firstNamefocusNode = new FocusNode();
  FocusNode lastNamefocusNode = new FocusNode();
  FocusNode emailfocusNode = new FocusNode();
  FocusNode ph_nofocusNode = new FocusNode();
  FocusNode dobfocusNode = new FocusNode();
  User? user;
  String? img64;
  String? profile_pic;
  var image;
  var imagePath;
  @override
  void initState() {
    user = UserPreferences.getUser(widget.userId!);
    imagePath = '${widget.accountInfo!.data.userData.profile_pic}'.isEmpty ||
            '${widget.accountInfo!.data.userData.profile_pic}'.contains('null')
        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
        : '${widget.accountInfo!.data.userData.profile_pic}';
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().DarkRed,
          title: Text('Edit Profile',
              style: TextStyle(fontWeight: FontWeight.w500)),
          centerTitle: true,
          actions: [Icon(Icons.search)],
        ),
        body: Container(
          height: ScreenUtil().screenHeight,
          padding:
              EdgeInsets.symmetric(horizontal: 100.h / 3, vertical: 100.h / 3),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_img.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: BlocProvider(
                create: (context) =>
                    AccountBloc(authRepo: context.read<UserRepository>()),
                child: buildForm()),
          ),
        ),
      ),
      designSize: Size(1080, 1920),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: EdgeInsets.only(left: 70.h, right: 70.h),
      child: Column(
        children: [
          buildPicture(img: '${widget.accountInfo!.data.userData.profile_pic}'),
          Padding(
            padding: EdgeInsets.only(top: 60.h, bottom: 40.h),
          ),
          firstName(),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
          ),
          lastName(),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
          ),
          email(),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
          ),
          PhoneNo(),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
          ),
          Dob(),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
          ),
          submitButton(),
        ],
      ),
    );
  }

  Widget buildTextField({
    FocusNode? focusNode,
    TextEditingController? controller,
    IconData? icon,
    String? text,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        hintText: text,
        hintStyle: TextStyle(
            color: focusNode!.hasFocus ? Colors.white : Colors.transparent,
            fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget submitButton() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return ElevatedButton(
          onPressed: () async {
            context.read<AccountBloc>().add(updateAccountDetails(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                phone_no: phoneNoController.text,
                profile_pic: profile_pic,
                dob: dobController.text,
                token: '${user!.data.accessToken}',
                accountInfo: widget.accountInfo));

            Navigator.pushNamed(context, '/home',
                arguments: HomeScreenArguments(userId: widget.userId));
          },
          child: Text(
            'SUBMIT',
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
    });
  }

  Widget buildPicture({required String img}) {
    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () async {
                 
                  image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
               
                  final bytes = await Io.File(image.path).readAsBytesSync();
                  img64 = base64Encode(bytes);
               

                  setState(() {
                  

                    imagePath = image!.path;
                    final str = imagePath.substring(40);
                    var value = str.replaceAll('.', '/');

                   profile_pic = 'data:$value;base64,${img64}';
                   
                  });
                },
                child: Ink.image(
                  image: image != null
                      ? FileImage(Io.File(imagePath)) as ImageProvider
                      : NetworkImage(imagePath),
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128,
                ))));
  }

  Widget firstName() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return buildTextField(
        focusNode: firstNamefocusNode,
        controller: firstNameController,
        icon: Icons.person,
        text: 'First Name',
      );
    });
  }

  Widget lastName() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return buildTextField(
        focusNode: lastNamefocusNode,
        controller: lastNameController,
        icon: Icons.person,
        text: 'Last Name',
      );
    });
  }

  Widget email() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return buildTextField(
        focusNode: emailfocusNode,
        controller: emailController,
        icon: Icons.mail,
        text: 'Email',
      );
    });
  }

  Widget PhoneNo() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return buildTextField(
        focusNode: ph_nofocusNode,
        controller: phoneNoController,
        icon: Icons.phone_android,
        text: 'Phone No',
      );
    });
  }

  Widget Dob() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return buildTextField(
        focusNode: dobfocusNode,
        controller: dobController,
        icon: Icons.cake,
        text: 'DOB',
      );
    });
  }
}
