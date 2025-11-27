import 'package:flutter/material.dart';



class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({required this.onPressed,required this.textColor,required this.color,required this.title,required this.height,required this.width});
  void Function() onPressed;
  Color textColor;
  Color color;
  String title;
  double width;
  double height;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
           style:ButtonStyle(
               shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
               backgroundColor: MaterialStateProperty.all(color),foregroundColor: MaterialStateProperty.all(textColor)),
          onPressed:onPressed,
          child:Text(title),
      ),
    );
  }
}
