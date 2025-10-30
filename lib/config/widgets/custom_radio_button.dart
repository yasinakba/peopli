import 'package:flutter/material.dart';

import '../app_colors/app_colors_light.dart';

class CustomRadioButton extends StatelessWidget {

  CustomRadioButton({required this.style,required this.onPressed,required this.color,required this.title,required this.height,required this.width});
  void Function() onPressed;
  Color color;
  String title;
  double width;
  double height;
  TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            style:ButtonStyle(

                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),

                    side: BorderSide(width: 1,color: AppLightColor.rectangleBold)
                ),
                ),
                backgroundColor: MaterialStateProperty.all(color),

            ),
            onPressed:onPressed,

            child:Text(title,style:style ,)
        )
    );
  }
}
