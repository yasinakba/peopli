import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/edit_profile/edit_profile_Screen.dart';
import 'package:test_test_test/features/login/login_screen.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';

class HeaderProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        print(controller.currentUser);
        return Container(
          width: 375.w,
          height: 180.h,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: CircleAvatar(
                      backgroundImage: controller.currentUser.avatar.isNotEmpty
                          ? NetworkImage(
                              "$baseImageURL/${controller.currentUser.avatar}",
                            )
                          : NetworkImage('$baseImageURL/noavatar.png'),
                    ),
                  ),
                  Column(
                    children: [
                    //   Text(
                    //     controller.memoryList.length.toString(),
                    //     style: appThemeData.textTheme.displaySmall,
                    //   ),
                    //   Text("Posts", style: appThemeData.textTheme.titleMedium),
                    ],
                  ),
                  Column(
                    children: [
                      Text(controller.memoryList.length.toString(), style: appThemeData.textTheme.displaySmall),
                      Text("Peopli", style: appThemeData.textTheme.titleMedium),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: 370.w,
                padding: EdgeInsetsDirectional.only(top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.currentUser?.displayName??'',
                    style: appThemeData.textTheme.headlineLarge,
                  ),
                  Text(
                    controller.currentUser.role?.toString() ?? 'null',
                    style: appThemeData.textTheme.bodyLarge,
                  ),
                  Text(
                    "${controller.currentUser?.birthdate??''} - now",
                    style: appThemeData.textTheme.bodyLarge,
                  ),
                  // SizedBox(
                  //   width: 175.w,
                  //   child: Text(
                  //     controller.currentUser[0].c ?? '',
                  //     style: appThemeData.textTheme.bodyLarge,
                  //     maxLines: 3,
                  //   ),
                  // ),
                ],
              ),

            CustomElevatedButton(
                      onPressed: () {
                        if(controller.doesNotAuth){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(currentUser: controller.currentUser,),),);
                        }
                      },
                      textColor: AppLightColor.strokePositive,
                      color: AppLightColor.withColor,
                      title:controller.doesNotAuth? 'Login/SignUp' :"Edit Profile",
                      height: 31.h,
                      width: 130.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
