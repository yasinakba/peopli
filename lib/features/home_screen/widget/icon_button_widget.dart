import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
class IconButtonAppbar extends StatelessWidget {
  const IconButtonAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios_new,color: AppLightColor.textBoldColor,));
  }
}
