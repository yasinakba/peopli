import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';

import '../../create_person/entity/face_entity.dart';
import '../../first_screen/entity/memory_entity.dart';

class PersonController extends GetxController {
  late FaceEntity face;
  int ratingCount = 0;
  bool isToggled = false;
  double ratingNumber = 0;
  int totalPage = 1;
  bool loading = false;

  late final PagingController<int, MemoryEntity> pagingMemoryController =
  PagingController<int, MemoryEntity>(
    getNextPageKey: (state) =>
    state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreMemories(pageKey),
  );


  final Dio dio = Dio();
  Future<void> voteFace(faceId) async {
    if (await checkInternet() == false) {
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
          'value': ratingNumber,
          'token': token,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response.data);
      if (response.statusCode == 200) {
        ratingCount++;
        update(['rating']);
        Get.snackbar('Succeed', 'Thanks for your rate 🌹🌹');
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



  Future<List<MemoryEntity>> readMoreMemories(int pageKey) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    final response = await dio.get(
      '$baseURL/Api/Memories',
      queryParameters: {
        'token': token,
        'page': pageKey,
        'take': 15,
        'faceId': face.id,
        'sortBy': 'newest',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data']['memories'];

      return data.map((e) => MemoryEntity.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load memories');
    }
  }

  }
