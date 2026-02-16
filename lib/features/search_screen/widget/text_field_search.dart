import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/app_theme/app_theme.dart';

class TextFieldSearch extends StatelessWidget {
  TextFieldSearch({ required this.labelText,required this.controller,this.onChange});
    String labelText;
    ValueChanged? onChange;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      height: 32.h,
      child: TextFormField(
        onChanged: onChange,
          controller: controller,
           decoration: InputDecoration(border: OutlineInputBorder(
             borderRadius: BorderRadius.all(Radius.circular(25)),
           ),
             labelText: labelText,
             labelStyle: (appThemeData.textTheme.bodySmall)

           ),

    )


      ,
    );
  }
}
