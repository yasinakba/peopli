import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';
import 'package:test_test_test/features/share_feature/share_memory_model.dart';

import '../controller/shared_memory_controller.dart';


class SharedMemoryScreen extends StatelessWidget {
  final dynamic id;

  SharedMemoryScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    // getMemoryShared(id: );
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SharedMemoryController>(
          initState: (state) {
            Get.find<SharedMemoryController>().readMemoryShared(id: id);
          },
          builder: (logic) {
        return Container(
            color: Colors.white,
            width: 360.w,
            height: 600.h,
            child: PostFirstScreen(logic.memoryList.first, 0,));
      }),
    );
  }
}
