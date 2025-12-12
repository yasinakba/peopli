import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';
import 'package:test_test_test/features/profile_screen/entity/comment_entity.dart';
import 'package:test_test_test/features/profile_screen/entity/user_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_theme/app_theme.dart';

class CommentProfile extends StatelessWidget {
  final List<UserEntity> currentUser;

  CommentProfile(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return SizedBox(
        height: 432.h,
        child: PagingListener(
          controller: controller.pagingCommentPerfectController,
          builder: (context,comment, index) {
            MyCommentEntity c = controller.myCommentList.first;
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 345.w,
                decoration: BoxDecoration(
                    color: AppLightColor.backgoundPost,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  children: [
                    //famous
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 125.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      c.text ?? 'null',
                                      style: appThemeData.textTheme
                                          .headlineLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   child: Text(
                                  //    memory.text ?? '',
                                  //     style: appThemeData.textTheme.bodyLarge,
                                  //     textAlign: TextAlign.start,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "${c.createdAt?.substring(0,4)} - now",
                                      style: appThemeData.textTheme.bodyLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Avenue 13, Bond Pavilion ...",
                                      style: appThemeData.textTheme.bodyLarge,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 115.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 55.w,
                                    height: 55.h,
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: NetworkImage(
                                        "$baseImageURL/${c.user?.avatar??''}",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: SizedBox(
                                      width: 20.w,
                                      height: 20.w,
                                      child: Text("2.0"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //post
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 5),
                          child: SizedBox(
                            width: 44.w,
                            height: 44.h,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage('$baseImageURL/${c.faceAvatar}'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              SizedBox(width: 130.w,
                                  child: Text(c.faceName??'',
                                    style: appThemeData.textTheme.labelMedium,
                                    textAlign: TextAlign.start,)),
                              SizedBox(width: 130.w,
                                  height: 15,
                                  child: Align(alignment: Alignment.bottomLeft,
                                      child: Icon(Icons.circle,
                                        color: AppLightColor.negativeFill,
                                        size: 10,))),

                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, bottom: 5),
                                  child: SizedBox(
                                    width: 33.w,
                                    height: 33.h,
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: NetworkImage(
                                        "$baseImageURL/${c.user?.avatar??''}",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(width: 130.w,
                                          child: Text(c.text??'',
                                            style: appThemeData.textTheme
                                                .labelMedium,
                                            textAlign: TextAlign.start,)),
                                      SizedBox(width: 130.w,
                                          height: 15,
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(Icons.circle,
                                                color: AppLightColor
                                                    .negativeFill, size: 10,))),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                            //Description
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 5),
                              child: SizedBox(

                                  child: AutoSizeText(
                                    c.memoryTitle??'',
                                    maxLines: 3,
                                    style: appThemeData.textTheme.labelLarge,
                                    textAlign: TextAlign.start,)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Description
                    Padding(
                      padding: const EdgeInsets.only(left: 20,
                          right: 20,
                          top: 5),
                      child: SizedBox(
                          child: AutoSizeText(
                            c.text??'',
                            maxLines: 3,
                            style: appThemeData.textTheme.headlineLarge,
                            textAlign: TextAlign.start,)),
                    ),

                  ],
                ),
              ),
            );
          },),
      );
    });
  }
}
