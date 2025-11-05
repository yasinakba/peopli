import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/widgets/custom_appbar.dart';

import '../../config/app_colors/app_colors_light.dart';
import 'controller/profile_controller.dart';
import 'widget/header.dart';
import 'widget/post_comment.dart';
class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLightColor.withColor,
      body:CustomScrollView(
        slivers: [
          CustomeAppBar(),
          SliverToBoxAdapter(child: HeaderProfile()),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                  height: 520.h,
                  child: PostComment()),
            ),
          ),

        ],
      )
    );
  }
}



