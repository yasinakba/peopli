import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';

class TextFiildMemory extends StatelessWidget {
  TextFiildMemory({required this.labelText,required this.iconT,required this.onPressed});
  String labelText;
  Icon iconT;
  void Function() onPressed;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 254.w,
      height: 32.h,
      child: TextFormField(

        decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: onPressed,icon: iconT,color: AppLightColor.elipsStroke,iconSize: 14,),
            border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
            labelText: labelText,
            labelStyle: (appThemeData.textTheme.bodySmall)

        ),

      ),

    );
  }
}