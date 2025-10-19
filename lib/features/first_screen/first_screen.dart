import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/first_screen/widget/list_view_profile.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';
import '';

import '../../config/app_colors/app_colors_light.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  FirstController firstController = Get.put(FirstController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FirstController>(
        builder: (controller) {
          return controller.isLoadingMemories
              ? SpinKitFadingCube(
                  duration: Duration(seconds: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.green : Colors.blue,
                      ),
                    );
                  },
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: AppLightColor.cancelButtonFill,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 100.h,
                              child: ListViewProfile(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //divider
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: AppLightColor.cancelButtonFill,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 590.h,
                        width: 360.w,
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
                                    final face = controller.faceList.firstWhere(
                                      (i) => i.id == memory.faceId,
                                      orElse: () =>
                                          FaceEntity(), // Return empty face if not found
                                    );
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: PostFirstScreen(
                                        memory,
                                        index,
                                        face,
                                      ),
                                    );
                                  },
                                  // Optional placeholders for better UX
                                  firstPageProgressIndicatorBuilder:
                                      (context) => Padding(
                                        padding: EdgeInsets.all(10),
                                        child: SpinKitFadingCube(
                                          duration: Duration(seconds: 1),
                                          itemBuilder: (BuildContext context, int index) {
                                                return DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: index.isEven
                                                        ? Colors.green
                                                        : Colors.blue,
                                                  ),
                                                );
                                              },
                                        ),
                                      ),

                                  newPageProgressIndicatorBuilder: (context) =>
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: SpinKitFadingCube(
                                          duration: Duration(seconds: 1),
                                          itemBuilder:
                                              (
                                                BuildContext context,
                                                int index,
                                              ) {
                                                return DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: index.isEven
                                                        ? Colors.green
                                                        : Colors.blue,
                                                  ),
                                                );
                                              },
                                        ),
                                      ),

                                  noItemsFoundIndicatorBuilder: (context) =>
                                      const Center(
                                        child: Text("No memories found."),
                                      ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
