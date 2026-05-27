import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';
import 'package:test_test_test/features/share_feature/share_memory_model.dart';

import '../controller/shared_memory_controller.dart';

class SharedMemoryScreen extends StatelessWidget {
  final dynamic id;

  const SharedMemoryScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memory Shared"), // Add a title for better UX
      ),
      body: GetBuilder<SharedMemoryController>(
        // ✅ 1. Trigger the API call when the widget initializes
        initState: (state) {
          Get.find<SharedMemoryController>().readMemoryShared(id: id);
        },
        builder: (logic) {
          // ✅ 2. Check if data is loading
          if (logic.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ✅ 3. Check if the list is empty (The Fix!)
          if (logic.memoryList.isEmpty) {
            return const Center(
              child: Text(
                "No memory found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          // ✅ 4. Now it's safe to access .first
          final memory = logic.memoryList.first;

          return Container(
            color: Colors.white,
            width: 360.w,
            height: 600.h,
            child: PostFirstScreen(memory, 0),
          );
        },
      ),
    );
  }
}
