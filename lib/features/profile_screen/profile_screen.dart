import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/app_colors/app_colors_light.dart';
import 'controller/profile_controller.dart';
import 'widget/header.dart';
import 'widget/post_comment.dart';
class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLightColor.withColor,
      body:Column(
        children: [
          HeaderProfile(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child:   SizedBox(height:590.h,child: PostComment())),
        ],
      )
    );
  }
}



