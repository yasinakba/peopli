import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';
import 'package:test_test_test/features/profile_screen/widget/post_profile2.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../create_person/entity/face_entity.dart';
import '../../first_screen/widget/post_first_screen.dart';

class TabBarShowPost extends StatelessWidget {
  const TabBarShowPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: AppLightColor.withColor,
          body: Column(
            children: [
              Container(
                height: 30.h,
                width: 375.w,
                child: TabBar(
                  unselectedLabelColor: AppLightColor.elipsFill,
                  labelColor: AppLightColor.textBoldColor,
                  indicatorColor: AppLightColor.withColor,
                  tabs: [
                    Container(
                        width: 112.w,
                        height: 16.h,
                        child: Icon(Icons.list)
                    ),
                    Container(
                        width: 112.w,
                        height: 16.h,
                        child: Icon(Icons.border_all)
                    ),
                  ],
                ),
              ),
              Container(
                height: 432.h,
                color: AppLightColor.withColor,
                child: TabBarView(
                  children: [
                    GetBuilder<ProfileController>(
                        initState: (state) {
                          Get.lazyPut(() => FirstController(),);
                        },
                        builder: (controller) {
                      return PagingListener(
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
                                  try{
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: PostFirstScreen(
                                        memory,
                                        index,
                                      ),
                                    );
                                  }catch(e){
                                    print(e);
                                  }
                                  return Container();

                                },
                                // Optional placeholders for better UX
                                firstPageProgressIndicatorBuilder:
                                    (context) => LoadingWidget(),
                                newPageProgressIndicatorBuilder: (context) => LoadingWidget(),
                                noItemsFoundIndicatorBuilder: (context) => const Center(child: Text("No memories found."),),
                              ),
                            ),
                      );
                    }),
                    Center(
                        child: PostProfile2()
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
