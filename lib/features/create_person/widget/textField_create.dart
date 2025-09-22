import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_theme/app_theme.dart';

class TextFieldCreate extends StatelessWidget {
 TextFieldCreate({required this.labelText});
  String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      height: 32.h,
      child: TextFormField(

        decoration: InputDecoration(border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
            labelText: labelText,
            labelStyle: (appThemeData.textTheme.bodySmall)

        ),

      ),

    );
  }
}
