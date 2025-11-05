import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import 'comment_profile.dart';
import 'comment_profile2.dart';

class TabBarShowComment extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return DefaultTabController(length: 2,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: AppLightColor.withColor,
            body: Column(
              children: [
                Container(
                  height: 30.h,
                  width: 375.w,
                  child: TabBar(
                    unselectedLabelColor: AppLightColor.elipsFill,
                    labelColor: AppLightColor.textBoldColor,
                    indicatorColor: AppLightColor.withColor,
                    tabs: [
                      Container(
                          width: 112.w,
                          height: 16.h,
                          child: Icon(Icons.list)
                      ),
                      Container(
                          width: 112.w,
                          height: 16.h,
                          child: Icon(Icons.border_all)
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppLightColor.withColor,
                    child: TabBarView(
                      children: [
                        CommentProfile(controller.currentUser),

                        Center(
                            child: CommentProfile2()
                        ),


                      ],
                    ),
                  ),
                ),


              ],
            ),

          ));
    });
  }
}
