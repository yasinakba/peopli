import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/widgets/custom_appbar.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/first_screen/widget/list_view_profile.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';

import '../../config/app_colors/app_colors_light.dart';

class FirstScreen extends StatelessWidget {
  FirstController firstController = Get.put(FirstController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstController>(
      builder: (controller) {
        // if (controller.isLoadingMemories) {
        //   return LoadingWidget();
        // }

        return Column(
          children: [
            CustomAppBar(),
            Container(
              width: double.infinity,
              height: 1,
              color: AppLightColor.cancelButtonFill,
            ),

            Container(
              padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                height: 120.h,
                child: ListViewProfile(),
              ),

            Container(
              width: double.infinity,
              height: 1,
              color: AppLightColor.cancelButtonFill,
            ),

            /// ✅ Use Expanded instead of fixed height
            Expanded(
              child: PagingListener(
                controller: controller.pagingMemoryController,
                builder: (context, state, fetchNextPage) {
                  return PagedListView<int, dynamic>(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, memory, index) {
                        Get.find<FirstController>().likeCount.add(memory.likesCount?.toInt()??0);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: PostFirstScreen(memory, index),
                        );
                      },
                      firstPageProgressIndicatorBuilder: (context) =>
                          LoadingWidget(),
                      newPageProgressIndicatorBuilder: (context) =>
                          LoadingWidget(),
                      noItemsFoundIndicatorBuilder: (context) =>
                      const Center(child: Text("No memories found.")),
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

