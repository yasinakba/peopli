import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/app_colors/app_colors_light.dart';



class BottomNavbarWidget extends StatelessWidget {
  BottomNavbarWidget({required this.assetsImage,this.colorIcon,required this.onTap});
String assetsImage;
Color? colorIcon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return    InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 25,
        width: 29,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(assetsImage,color:colorIcon,fit: BoxFit.cover),
        )

      ),
    );
  }
}
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(100))
// ),
// child: ),