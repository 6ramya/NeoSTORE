import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxFormField extends StatefulWidget {
  const CheckBoxFormField({Key? key}) : super(key: key);

  @override
  _CheckBoxFormFieldState createState() => _CheckBoxFormFieldState();
}

class _CheckBoxFormFieldState extends State<CheckBoxFormField> {
  bool _checked = true;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return FormField(
          builder: (state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: _checked,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            _checked = !_checked;
                          });
                        }),
                    Text('I agree the Terms & Conditions',
                        style: TextStyle(color: Colors.white, fontSize: 39.sp)),
                  ],
                ),
                Text(
                  state.errorText ?? '',
                  style: TextStyle(
                      color: Theme.of(context).errorColor, fontSize: 11),
                )
              ],
            );
          },
          validator: (value) {
            if (!_checked) {
              return 'You need to accept terms';
            } else {
              return null;
            }
          },
        );
      },
      designSize: Size(1080, 1920),
    );
  }
}
