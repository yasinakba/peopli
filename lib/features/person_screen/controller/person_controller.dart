
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
class PersonController extends GetxController{
  bool isToggled = false;
  double ratingNumber=0;

  final Dio dio = Dio();
  Future<void> voteFace(faceId) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        '$baseURL/Api/Faces/vote/$faceId',
        queryParameters: {
          'value':ratingNumber,
          'token':token,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response.data);
      if (response.statusCode == 200) {
        Get.snackbar('Succeed', 'Thanks for your tare 🌹🌹');
        update();
      } else {
        debugPrint(
          "❌ Error: ${response.statusCode} -> ${response.statusMessage}",
        );
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
}