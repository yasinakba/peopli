import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../entity/comment_entity.dart';


class CommentProfile2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return SizedBox(
          height: 500.h,
          child: PagingListener<int, CommentEntity>(
            controller: controller.pagingCommentController,
            builder: (context, state, fetchNextPage) {
              return PagedGridView<int, CommentEntity>(
                state: state,
                fetchNextPage: fetchNextPage,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                builderDelegate:
                PagedChildBuilderDelegate<CommentEntity>(
                  itemBuilder: (context, c, index) {
                    return SizedBox(
                      height: 130.w,
                      width: 130.w,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                '$baseImageURL/${c.faceAvatar ?? 'noavatar.png'}',
                                width: 90.w,
                                height: 90.w,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Container(color: Colors.grey),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                '$baseImageURL/${c.user?.avatar ?? 'noavatar.png'}',
                                width: 50.w,
                                height: 50.w,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Container(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

