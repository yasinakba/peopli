import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../first_screen/entity/memory_entity.dart';

class HeartController extends GetxController{
  List<MemoryEntity> memoryList = [];
  int memoryPage = 1;
  ScrollController scrollMemoryController = ScrollController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    readMemories();
    scrollMemoryController.addListener(() {
      if (scrollMemoryController.position.pixels >=
          scrollMemoryController.position.maxScrollExtent) {
        memoryPage++;
        readMoreMemories();
      }
    });
  }
  final dio = Dio();
  Future<void> readMemories() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memories/likes?token=$token&page=1&take=15&sortBy=latest',
        options: Options(
          headers: {
            // 'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        // ✅ Success
        List<dynamic> data = response.data['data']['memories'];
        memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e),));
        update();
        debugPrint("Memories: ${response.data}");
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> readMoreMemories() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memories/likes?token=$token&page=$memoryPage&take=15&sortBy=latest',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['memories'];
        memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e),));
        debugPrint("Memories: ${response.data}");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
}