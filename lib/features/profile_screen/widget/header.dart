import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';


import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';

class HeaderProfile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80.w,
                  height: 80.h,
                  child:CircleAvatar(
                    backgroundImage: controller.currentUser.isNotEmpty
                        ? NetworkImage("https://api.peopli.ir/uploads/${controller.currentUser.first.avatar}")
                        : const NetworkImage('https://api.peopli.ir/uploads/noavatar.png') as ImageProvider,
                  ),
                ),
                Column(
                  children: [
                    Text("12", style: appThemeData.textTheme.displaySmall,),
                    Text("Posts", style: appThemeData.textTheme.titleMedium,),
                  ],
                ),
                Column(
                  children: [
                    Text("87", style: appThemeData.textTheme.displaySmall,),
                    Text("Peopli", style: appThemeData.textTheme.titleMedium,),

                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 15, end: 15, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 125.w,
                  child: Column(
                    children: [
                      SizedBox(width: double.infinity,
                          child: Text(controller.currentUser.isNotEmpty?controller.currentUser.first.displayName:'null', style: appThemeData
                              .textTheme.headlineLarge, textAlign: TextAlign.start,)),
                      // SizedBox(width: double.infinity,
                      //     child: Text(
                      //       controller.currentUser.first.??'Unknown', style: appThemeData
                      //         .textTheme.bodyLarge, textAlign: TextAlign
                      //         .start,)),
                      SizedBox(width: double.infinity,
                          child: Text(controller.currentUser.isNotEmpty?"${controller.currentUser.first.birthdate.toString()} - now":'null', style: appThemeData
                              .textTheme.bodyLarge, textAlign: TextAlign
                              .start,)),
                      // SizedBox(width: double.infinity,
                      //     child: Text(
                      //       controller.currentUser.first.lastKnownLocation??'', style: appThemeData
                      //         .textTheme.bodyLarge,
                      //       textAlign: TextAlign.start,
                      //       maxLines: 1,)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 23),
                  child: CustomElevatedButton(onPressed: () {
                    Get.toNamed(NamedRoute.routeEditProfiletScreen,arguments: controller.currentUser[0]);},
                      textColor: AppLightColor.strokePositive,
                      color: AppLightColor.withColor,
                      title: "Edit Profile",
                      height: 27.h,
                      width: 100.w),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
