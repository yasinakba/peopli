import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:get/get.dart';

import '../../../config/app_theme/app_theme.dart';

class TextFieldCreateAccount extends StatefulWidget {
  TextFieldCreateAccount(
      {super.key, required this.labelText, required this.controller,this.obSecure});

  String labelText;
  TextEditingController controller;
  bool? obSecure;

  @override
  State<TextFieldCreateAccount> createState() => _TextFieldCreateAccountState();
}

class _TextFieldCreateAccountState extends State<TextFieldCreateAccount> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      height: 30.h,
      child: TextFormField(
          obscureText:widget.obSecure==null?false:widget.obSecure!,
          controller: widget.controller,
          decoration: InputDecoration(border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
              suffixIcon: IconButton(onPressed: () {
                setState(() {
                widget.obSecure = !widget.obSecure!;
                });
              }, icon: Icon(widget.obSecure == null?null:widget.obSecure!?FrinoIcons.f_eye:FrinoIcons.f_eye_slash)),
              labelText: widget.labelText,
              labelStyle: (appThemeData.textTheme.bodySmall)

          ),

        )

    );
  }
}
