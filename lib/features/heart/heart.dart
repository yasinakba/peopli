import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/heart/heart_controller.dart';

import '../first_screen/controller/first_controller.dart';
import '../first_screen/widget/post_first_screen.dart';
import '../profile_screen/controller/profile_controller.dart';

class HeartScreen extends StatefulWidget {
  bool isLiked = false;

  @override
  State<HeartScreen> createState() => _HeartScreenState();
}

class _HeartScreenState extends State<HeartScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<HeartController>(
          initState: (state) {
            Get.lazyPut(() => ProfileController());
            Get.lazyPut(() => DateController());
            Get.lazyPut(() => HeartController());
            Get.lazyPut(() => FirstController());
          },
          builder: (controller) {
            return SizedBox(
              height: Get.height *.91,
              width: Get.width,
              child: PagingListener(
                controller: controller.pagingMemoryController,
                builder: (context, state, fetchNextPage) =>
                    PagedListView<int, dynamic>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<dynamic>(
                        itemBuilder: (context, memory, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: PostFirstScreen(memory, index),
                          );
                        },
                        // Optional placeholders for better UX
                        firstPageProgressIndicatorBuilder: (context) =>
                            LoadingWidget(),
                        newPageProgressIndicatorBuilder: (context) =>
                            LoadingWidget(),
                        noItemsFoundIndicatorBuilder: (context) => Center(
                          child: Text(
                            "No memories found.",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
            );
          },
        ),
      ],
    );
  }
}
