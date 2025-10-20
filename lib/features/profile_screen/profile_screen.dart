import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_jpg.dart';
import 'controller/profile_controller.dart';
import 'widget/header.dart';
import 'widget/post_comment.dart';
import 'widget/tabbar_show.dart';
class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLightColor.withColor,
      body:Column(
        children: [
          HeaderProfile(),
          //postComment
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
                height: 500.h,
                child: PostComment()),
          ),

        ],
      )
    );
  }
}



