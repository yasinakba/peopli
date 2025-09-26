import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/profile_screen/entity/user_entity.dart';

class ProfileController extends GetxController {

  late TabController tabController;
  List<User> currentUser = [];

  @override
  void onInit() {
    super.onInit();
  }

  final dio = Dio();

  Future<void> getCurrentAccount() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Account',
        queryParameters: {
          'token': token,
        },
      );

      debugPrint("✅ Response received: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        final data = response.data['data'] as Map<String, dynamic>;
        final user = User.fromJson(data);
        currentUser.add(user); // if currentUser is a List<User>
        update();
        debugPrint("✅ currentUser updated: ${currentUser.length} users");
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
}