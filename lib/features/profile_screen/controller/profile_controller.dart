import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/profile_screen/entity/user_entity.dart';

import '../../first_screen/entity/memory_entity.dart';

class ProfileController extends GetxController {
  final dio = Dio();
  @override
  void onInit() {
    super.onInit();
    getCurrentAccount();

    scrollMemoryController.addListener(() {
      if (scrollMemoryController.position.pixels >=
          scrollMemoryController.position.maxScrollExtent) {
        memoryPage++;
        readMoreMemories();
      }
    });
  }
  Future<void> getCurrentAccount() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.get('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Account',
        queryParameters: {
          'token': token.toString(),
        },
      );

      debugPrint("✅ Response received: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        final data = response.data['data'] as Map<String, dynamic>;
        final user = UserEntity.fromJson(data);
        currentUser.add(user); // if currentUser is a List<User>
        debugPrint("✅ currentUser updated: ${currentUser.length} users");
        preferences.setInt('userId', currentUser.first.id);
        readMemories();
        update();
      } else {
        debugPrint(
            "❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching account: $e");
      debugPrint(stacktrace.toString());
    }
  }
  List<MemoryEntity> memoryList = [];
  int memoryPage = 1;
  ScrollController scrollMemoryController = ScrollController();
  late TabController tabController;
  List<UserEntity> currentUser = [];

  Future<void> readMemories() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memories?token=$token&page=1&take=15&sortBy=latest&userId=${currentUser.first.id}',
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
        'https://api.peopli.ir/Api/Memories?token=$token&page=$memoryPage&take=15&sortBy=latest&userId=${currentUser.first.id}',
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