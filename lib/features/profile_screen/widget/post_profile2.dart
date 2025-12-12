import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';
import '../../../config/app_string/constant.dart';

class PostProfile2 extends StatelessWidget {
  const PostProfile2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      initState: (state) {
        Get.lazyPut(() => ProfileController());
      },
      builder: (logic) {
        return PagingListener(
          controller: logic.pagingMemoryController,
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
                if (item is! MemoryEntity) return SizedBox();
                final memory = item;

                final userAvatar = logic.currentUser.isNotEmpty
                    ? logic.currentUser.first.avatar
                    : '';

                return Container(
                  padding: EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      // Main avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90.w),
                        child: Image.network(
                          '$baseImageURL/${memory.faceAvatar}',
                          width: 90.w,
                          height: 90.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 90.w,
                            height: 90.w,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      // Small overlay avatar
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              '$baseImageURL/$userAvatar',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  Container(color: Colors.grey),
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
        );
      },
    );
  }
}
