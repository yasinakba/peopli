

import 'package:flutter/material.dart';

import '../app_colors/app_colors_dark.dart';
import '../app_colors/app_colors_light.dart';
import '../app_fonts/app_font.dart';

final ThemeData appThemeData=ThemeData(
  colorScheme: ColorScheme.light(brightness: Brightness.light,secondaryContainer: AppLightColor.backgoundPost),

    // cardColor: ,
    brightness: Brightness.light,
  primaryColor: Colors.blueAccent,
  fontFamily: AppFonts.roboto,
    cardColor: AppLightColor.backgoundPost,
   hoverColor: AppLightColor.strokeRectangleType,
   scaffoldBackgroundColor: AppLightColor.withColor,
   textTheme: TextTheme(
     displayLarge: TextStyle(fontSize: 20,color: AppLightColor.cancelButtonFill,fontFamily:AppFonts.roboto),
      displayMedium: TextStyle(fontSize: 18,color: AppLightColor.strokeRectangleType,fontFamily:AppFonts.roboto,fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 18,color: AppLightColor.textBoldColor,fontFamily: AppFonts.roboto),
      headlineLarge: TextStyle(fontSize: 14,color: AppLightColor.textBoldColor,fontFamily: AppFonts.roboto,fontWeight:FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 14,color: AppLightColor.strokeRectangleType,fontFamily: AppFonts.roboto,fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 14,color: AppLightColor.textBoldColor,fontFamily: AppFonts.roboto,fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 14,color: AppLightColor.fillStrokeNeutral,fontFamily: AppFonts.roboto,fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 14,color: AppLightColor.cancelButtonFill,fontFamily: AppFonts.roboto),
      titleSmall: TextStyle(fontSize: 13,color: AppLightColor.textBlueColor,fontFamily: AppFonts.roboto),
      labelLarge: TextStyle(fontSize: 12,color: AppLightColor.strokeRectangleType,fontFamily: AppFonts.roboto,fontWeight: FontWeight.bold),
      labelMedium: TextStyle(fontSize: 12,color: AppLightColor.textBoldColor,fontFamily: AppFonts.roboto,),
      labelSmall: TextStyle(fontSize: 12,color: AppLightColor.withColor,fontFamily: AppFonts.roboto,fontWeight: FontWeight.bold),
     bodyLarge: TextStyle(fontSize: 10,color: AppLightColor.strokeRectangleType,fontFamily: AppFonts.roboto,fontWeight: FontWeight.bold),
     bodyMedium: TextStyle(fontSize: 10,color: AppLightColor.postNavbar,fontFamily: AppFonts.roboto),
     bodySmall: TextStyle(fontSize: 10,color: AppLightColor.textBlueColor,fontFamily: AppFonts.roboto,fontWeight: FontWeight.bold),
   )

);


//dark
final ThemeData darkAppThemeData=ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  fontFamily: AppFonts.roboto,
   scaffoldBackgroundColor: AppDarkColor.textBoldColor,
    cardColor: AppDarkColor.backgoundPost,
    hoverColor: AppDarkColor.strokeRectangleType,
    colorScheme: ColorScheme.dark(brightness: Brightness.dark,secondaryContainer: AppDarkColor.backgoundPost),
   textTheme: TextTheme(

       displayLarge: TextStyle(fontSize: 20,color: AppDarkColor.cancelButtonFill,fontFamily:AppFonts.roboto),
       displayMedium: TextStyle(fontSize: 18,color: AppDarkColor.strokeRectangleType,fontFamily:AppFonts.roboto,fontWeight: FontWeight.bold),
       displaySmall: TextStyle(fontSize: 18,color: AppDarkColor.cancelButtonFill),
       headlineLarge: TextStyle(fontSize: 14,color: AppDarkColor.textBoldColor,fontFamily: AppFonts.roboto,fontWeight:FontWeight.bold),
       headlineMedium: TextStyle(fontSize: 14,color: AppDarkColor.textBlueColor,fontFamily: AppFonts.roboto),
       headlineSmall: TextStyle(fontSize: 14,color: AppDarkColor.cancelButtonFill),
       titleLarge: TextStyle(fontSize: 14,color: AppDarkColor.cancelButtonFill),
       titleMedium: TextStyle(fontSize: 14,color: AppDarkColor.cancelButtonFill),
       titleSmall: TextStyle(fontSize: 13,color: AppDarkColor.cancelButtonFill),
       labelLarge: TextStyle(fontSize: 12,color: AppDarkColor.strokeRectangleType,fontFamily: AppFonts.roboto),
       labelMedium: TextStyle(fontSize: 12,color: AppDarkColor.textBoldColor),
       labelSmall: TextStyle(fontSize: 12,color: AppDarkColor.cancelButtonFill),
       bodyLarge: TextStyle(fontSize: 10,color: AppDarkColor.strokeRectangleType),
       bodyMedium: TextStyle(fontSize: 10,color: AppDarkColor.postNavbar),
       bodySmall: TextStyle(fontSize: 10,color: AppDarkColor.cancelButtonFill),










   )

);




