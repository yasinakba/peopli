import 'package:flutter/material.dart';



class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({required this.assetsImage,this.colorIcon,required this.onTap});
final String assetsImage;
final Color? colorIcon;
 final  void Function()? onTap;

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