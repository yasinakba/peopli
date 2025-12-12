import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';

import '../../first_screen/entity/memory_entity.dart';
class PersonController extends GetxController{
  int ratingCount = 0;
  bool isToggled = false;
  double ratingNumber=0;
  int totalPage = 1;
  bool loading = false;
  int faceId = 0;
  late final pagingMemoryController = PagingController<int, dynamic>(
    getNextPageKey: (state) =>
    state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreMemories(pageKey),
  );
  List<MemoryEntity> memoryList = [];

  final Dio dio = Dio();
  Future<void> voteFace(faceId) async {
    if(await checkInternet() == false){
      return;
    }
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
        ratingCount++;
        Get.snackbar('Succeed', 'Thanks for your rate 🌹🌹');
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  Future<List<MemoryEntity>> readMoreMemories(pageKey) async {
    if (pageKey <= totalPage) {
      loading =true;
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');


        final response = await dio.get(
          '$baseURL/Api/Memories',
          queryParameters: {
            'token': token,
            'page': pageKey,
            'take': 15,
            'faceId':faceId,
            'sortBy': 'newest',
          },
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
        if (response.statusCode == 200) {
          final List<dynamic> data = response.data['data']['memories'];
          totalPage = response.data['data']['pageCount'];
          loading = false;
          memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e)));
          print(memoryList);
          update();
          return memoryList;
        }
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        return memoryList;
      }
    }
    return [];
  }
}