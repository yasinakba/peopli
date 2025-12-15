import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/widgets/custom_appbar.dart';

import 'controller/profile_controller.dart';
import 'widget/header.dart';
import 'widget/post_comment.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 690.h,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomAppBarSliver(),
          SliverToBoxAdapter(child: HeaderProfile()),
          SliverToBoxAdapter(
            child: Container(
              height: 650.h,
              width: 375.w,
              child: PostComment(),
            ),
          ),
        ],
      ),
    );
  }
}
