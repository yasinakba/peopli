import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/first_screen/entity/comment_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';


class CommentProfile2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return SizedBox(
          height: 300.h,
          child: PagingListener(
            controller: controller.pagingCommentPerfectController,
            builder: (context, state, fetchNextPage) => PagedGridView(
              state: state,
              shrinkWrap: true,
              fetchNextPage: fetchNextPage,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items in each row
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              // your custom grid delegate
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) {
                  if (item is! CommentEntity) return SizedBox();
                  final c = item;

                 return Container(
                height: 130.w,
                width: 130.w,
                padding: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Container(
                      height: 90.w,
                      width: 90.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Image.network('$baseImageURL/${c.faceAvatar??'noavatar.png'}',fit: BoxFit.cover,),
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
                            fit: BoxFit.cover,
                            '$baseImageURL/${c.user?.avatar ?? 'noavatar.png'}',
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
          ),
        );
      },
    );
  }
}
