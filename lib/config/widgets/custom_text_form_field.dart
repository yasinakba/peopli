import 'package:flutter/material.dart';

import '../app_colors/app_colors_light.dart';
import '../app_theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key, required this.controller,required this.title});
  TextEditingController controller;
  String title;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      style: TextStyle(
        height: 1,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        filled: true,
        labelText: title,
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
