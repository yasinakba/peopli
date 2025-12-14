import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';


class CustomTextFormFieldPassword extends StatefulWidget {
   CustomTextFormFieldPassword({super.key, required this.controller,required this.title,required this.obSecureText});
  TextEditingController controller;
  String title;
  bool obSecureText;

  @override
  State<CustomTextFormFieldPassword> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: widget.controller,
      style: TextStyle(
        height: 1,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
            widget.obSecureText = !widget.obSecureText;
            });
          },
          icon: Icon(
            widget.obSecureText
                ? FrinoIcons.f_eye
                : FrinoIcons.f_eye_slash,
          ),
        ),
        filled: true,
        labelText: 'Password',
        labelStyle: appThemeData.textTheme.bodyLarge,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppLightColor.strokePositive,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
    );
  }
}
