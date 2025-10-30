import 'package:flutter/material.dart';



class CustomCreateButton extends StatelessWidget {
const  CustomCreateButton({required this.onPressed,required this.textColor,required this.color,required this.title,required this.height,required this.width});
  final void Function() onPressed;
 final  Color textColor;
 final  Color color;
 final  String title;
 final  double width;
 final  double height;


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

            child:Text(title)
        )
    );
  }
}
