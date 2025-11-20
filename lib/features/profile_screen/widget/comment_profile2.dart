import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/first_screen/entity/comment_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';
import 'package:test_test_test/features/profile_screen/entity/comment_entity.dart';

import '../../../config/app_icons/app_assets_jpg.dart';

class CommentProfile2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: PagingListener(
                controller: controller.pagingCommentController,
                builder: (context, comment, index) {
                  MyCommentEntity c = controller.myCommentList[0];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: Image.network('$baseURL/${c.faceAvatar}',fit: BoxFit.cover,),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 45,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              child: Image.network(
                                '$baseImageURL/${c.user?.avatar ?? ''}',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
