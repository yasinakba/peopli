import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomElevatedButton extends StatelessWidget {
   CustomElevatedButton({required this.onPressed,required this.textColor,required this.color,required this.title,required this.width,required this.height});
  void Function() onPressed;
  Color textColor;
  Color color;
  String title;
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w,vertical: 10.h),
        width: width,
        height: 40.h,
        child: ElevatedButton(
             style:ButtonStyle(
                 shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                 backgroundColor: MaterialStateProperty.all(color),foregroundColor: MaterialStateProperty.all(textColor)),
            onPressed:onPressed,
            child:Text(title),
        ),
      ),
    );
  }
}
