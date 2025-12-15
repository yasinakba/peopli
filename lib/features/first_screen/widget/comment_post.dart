import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../profile_screen/entity/comment_entity.dart';

class CommentPost extends StatelessWidget {
  final MemoryEntity memoryEntity;
  final FirstController firstController = Get.put(FirstController());
  final bool isFromProfile;
   CommentPost({required this.memoryEntity,this.isFromProfile = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstController>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${controller.commentList.length} Comment"),
            ),
            Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: 300.h,
                  width: 370.w,
                  decoration: BoxDecoration(),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.commentList.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      CommentEntity comment = controller.commentList[index];
                      if (controller.commentList.isEmpty) {
                        return Center(
                          child: Text('Does not any comment still'),
                        );
                      }
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
                                          backgroundImage: NetworkImage(
                                            "$baseImageURL/${comment.user?.avatar??''}",
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
                                              comment.user?.displayName??'',
                                              style: appThemeData
                                                  .textTheme
                                                  .labelMedium,
                                              textAlign: TextAlign.start,
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
                                            onPressed: () {
                                              controller.editComment(
                                                comment.id,
                                              );
                                            },
                                            icon: Icon(FrinoIcons.f_edit,color: Colors.black,),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller.deleteComment(
                                                comment.id,
                                              );
                                            },
                                            icon: Icon(FrinoIcons.f_delete,color: Colors.black,),
                                          ),
                                        ],
                                      ),
                                    ),
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
            Container(
              decoration: BoxDecoration(
                color: AppLightColor.withColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(
                width: 45.w,
                height: 45.h,
                child: Get.find<ProfileController>().currentUser.isNotEmpty &&
                    Get.find<ProfileController>().currentUser.first.avatar.isNotEmpty
                    ? CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                   "$baseImageURL/${Get.find<ProfileController>()
                       .currentUser
                       .first
                       .avatar}" ,
                  ),
                )
                    : CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "$baseImageURL/noavatar.png",
                  ),
                ),
              ),
              SizedBox(
                    width: 270.w,
                    height: 50,
                    child: TextField(
                      controller: controller.commentTextFieldController,
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
                    child: IconButton(
                      onPressed: () {
                        controller.addComment(memoryEntity.id);
                      },
                      icon: Icon(Icons.send),
                    ),
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
