import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frino_icons/frino_icons.dart';

import '../../../config/app_theme/app_theme.dart';

class TextFieldCreateAccount extends StatefulWidget {
  TextFieldCreateAccount({super.key, required this.labelText,required this.controller, this.obsecure});
  String labelText;
  TextEditingController controller;
  bool? obsecure;

  @override
  State<TextFieldCreateAccount> createState() => _TextFieldCreateAccountState();
}

class _TextFieldCreateAccountState extends State<TextFieldCreateAccount> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      height: 35.h,
      child: TextFormField(
        obscureText: widget.obsecure ?? false,
        controller: widget.controller,
        decoration: InputDecoration(border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
            suffixIcon:widget.obsecure!=null? IconButton(onPressed: () {
              setState(() {
              widget.obsecure = !widget.obsecure!;
              });
            },icon: Icon(widget.obsecure==true?FrinoIcons.f_eye:FrinoIcons.f_eye_slash)):null,
            labelText: widget.labelText,
            labelStyle: (appThemeData.textTheme.bodySmall)

        ),

      ),

    );
  }
}
