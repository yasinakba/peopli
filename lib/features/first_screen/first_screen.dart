import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/first_screen/widget/list_view_profile.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';
import '';

import '../../config/app_colors/app_colors_light.dart';

class FirstScreen extends StatelessWidget {
  FirstController firstController = Get.put(FirstController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FirstController>(
        builder: (controller) {
          return controller.isLoadingMemories?  SpinKitFadingCube(
            duration: Duration(seconds: 1),
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ): CustomScrollView(
            controller: controller.scrollMemoryController,
            slivers: [
              //divider
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: AppLightColor.cancelButtonFill,
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 100.h,
                    child: ListViewProfile(),
                  ),
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

              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  MemoryEntity memory = controller.memoryList[index];
                  if (controller.faceList.isNotEmpty) {
                    var face = controller.faceList
                        .where((i) => i.id == memory.id)
                        .singleOrNull;
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        right: 10,
                        left: 10,
                      ),
                      child: PostFirstScreen(
                        memory,
                        index,
                        face ?? FaceEntity(),
                      ),
                    );
                  }
                }, childCount: controller.memoryList.length),
              ),
            ],
          );
        },
      ),
    );
  }
}
