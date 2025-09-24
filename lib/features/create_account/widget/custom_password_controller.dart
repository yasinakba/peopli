import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:get/get.dart';

import '../../../config/app_theme/app_theme.dart';

class TextFieldCreateAccount extends StatelessWidget {
  TextFieldCreateAccount(
      {super.key, required this.labelText, required this.controller});

  String labelText;
  TextEditingController controller;
  RxBool obsecure = false.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      height: 30.h,
      child: Obx(() {
        return TextFormField(
          obscureText: obsecure.value,
          controller: controller,
          decoration: InputDecoration(border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
              prefix: IconButton(onPressed: () {
                obsecure.value = !obsecure.value;
              }, icon: Icon(obsecure.value?Icons.remove_red_eye_rounded:FrinoIcons.f_eye_slash)),
              labelText: labelText,
              labelStyle: (appThemeData.textTheme.bodySmall)

          ),

        );
      }),

    );
  }
}
