import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/profile_controller.dart';
import 'widget/header.dart';
import 'widget/post_comment.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderProfile(),
        Container(
          height: 570.h,
          padding: const EdgeInsets.only(top: 20),
          child: PostComment(),
        ),
      ],
    );
  }
}
