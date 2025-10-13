import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      body: GetBuilder<FirstController>(builder: (controller) {
        return Column(
          children: [
            //divider
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
            //divider
            Container(
              width: double.infinity,
              height: 1,
              color: AppLightColor.cancelButtonFill,
            ),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.memoryList.length,
                itemBuilder: (context, index) {
                  MemoryEntity memory = controller.memoryList[index];
                  return Padding(
                    padding: EdgeInsets.only(top: 10,
                        right: 10,
                        left: 10,
                        bottom: index == 3 ? 60 : 10),
                    child: PostFirstScreen(memory,index),
                  );
                },
              ),
            ),
          ],
        );
      })
      ,
    );
  }
}
