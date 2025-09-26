import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/comment_entity.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_theme/app_theme.dart';

class CommentPost extends StatelessWidget {
  final MemoryEntity memoryEntity;
  FirstController firstController = Get.put(FirstController());
   bool isFromProfile = false;
  CommentPost({required this.memoryEntity, required this.isFromProfile});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstController>(
      initState: (state) {
        firstController.getComment(memoryEntity.id);
      },
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text("${memoryEntity.commentsCount} Comment")],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 400.h,
                  width: 370.w,
                  decoration: BoxDecoration(),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.commentList.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      CommentEntity comment = controller.commentList[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                          right: 3,
                          bottom: 4,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppLightColor.backgoundPost,
                            border: Border.all(
                              color: AppLightColor.backgoundPost,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        left: 10,
                                        bottom: 5,
                                      ),
                                      child: SizedBox(
                                        width: 44.w,
                                        height: 44.h,
                                        child: CircleAvatar(
                                          radius: 80,
                                          backgroundImage: AssetImage(
                                            AppAssetsJpg.userPost,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 130.w,
                                            child: Text(
                                              memoryEntity.user ?? '',
                                              style: appThemeData
                                                  .textTheme
                                                  .labelMedium,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 130.w,
                                            height: 15,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(
                                                Icons.circle,
                                                color:
                                                    AppLightColor.negativeFill,
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                        visible: isFromProfile,
                                        child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(FrinoIcons.f_edit),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(FrinoIcons.f_delete),
                                        ),
                                      ],
                                    )),

                                  ],
                                ),
                                //Description
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 5,
                                  ),
                                  child: SizedBox(
                                    child: AutoSizeText(
                                      comment.text ?? 'null',
                                      maxLines: 3,
                                      style: appThemeData.textTheme.bodyLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppLightColor.withColor,
                border: Border.all(color: AppLightColor.textBoldColor),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 45.w,
                    height: 45.h,
                    child: CircleAvatar(
                      backgroundImage:
                          Get.find<ProfileController>()
                              .currentUser
                              .first
                              .avatar
                              .isNotEmpty
                          ? NetworkImage(
                              Get.find<ProfileController>()
                                  .currentUser
                                  .first
                                  .avatar
                                  .split('/')
                                  .last,
                            )
                          : AssetImage(AppAssetsJpg.imagePerson),
                      radius: 50,
                    ),
                  ),
                  SizedBox(
                    width: 270.w,
                    height: 50,
                    child: TextField(
                      cursorColor: Colors.blue,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        hintText: "Comment",
                        border: InputBorder.none,
                      ),
                      style: appThemeData.textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width: 45.w,
                    height: 45.h,
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
