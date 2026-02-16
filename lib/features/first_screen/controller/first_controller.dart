import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';
import 'package:test_test_test/features/share_feature/shared_memory_controller.dart';

import '../../feature_location/controller/location_controller.dart';
import '../../profile_screen/entity/comment_entity.dart';

class FirstController extends GetxController {
  String lastLocation = '';
  final dio = Dio();
  int memoryPage = 1;
  List<MemoryEntity> memoryList = [];
  late final pagingMemoryController = PagingController<int, MemoryEntity>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreMemories(pageKey),
  );
  late final pagingFaceController = PagingController<int, FaceEntity>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreFace(pageKey),
  );
  bool isLoadingMemories = false;
  bool isLoadingFaces = false;
  int lastLoadedPage = 0;
  int? idIsLiked;
  bool? isLiked;
  @override
  void onInit() {
    super.onInit();

    Get.lazyPut<SharedMemoryController>(() => SharedMemoryController());
    Get.lazyPut(() => LocationController(),);
    // Defer API calls until the next frame
    Future.delayed(Duration.zero, () {
      Get.find<LocationController>().getLocation();
    });
  }
  @override
  void onClose() {
    // TODO: implement dispose
    super.onClose();
    idIsLiked = null;
  }

  int totalPage = 1;


  Future<List<MemoryEntity>> readMoreMemories(pageKey) async {

    if (pageKey <= totalPage) {
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        final response = await dio.get(
          '$baseURL/Api/Memories',
          queryParameters: {
            'token': token,
            'page': pageKey,
            'take': 15,
            'sortBy': 'newest',
          },
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
        if (response.statusCode == 200) {
          final List<dynamic> data = response.data['data']['memories'];
          totalPage = response.data['data']['pageCount'];
          isLoadingMemories = false;
          memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e)));
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

  Future<List<FaceEntity>> readMoreFace(pageKey) async {
    if (facePage >= pageKey) {
      isLoadingFaces = true;
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        if (token == null) {
          debugPrint("⚠️ No token found in SharedPreferences");
          return faceList;
        }
        final response = await dio.get(
          '$baseURL/Api/Faces?token=$token&page=$pageKey&take=15&sortBy=closest',
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
        if (response.statusCode == 200) {
          // ✅ Success
          facePage = response.data['data']['pageCount'];
          List<dynamic> data = response.data['data']['faces'];
          faceList.addAll(data.map((e) => FaceEntity.fromJson(e)));
          isLoadingFaces = false;
          update();
          return faceList;
        } else {
          debugPrint(
            "❌ Error: ${response.statusCode} -> ${response.statusMessage}",
          );
          return faceList;
        }
      } catch (e, stacktrace) {
        debugPrint("🔥 Exception while fetching memories: $e");
        debugPrint(stacktrace.toString());
        return faceList;
      }
    }
    return [];
  }

  List<CommentEntity> commentList = [];
  int commentPage = 1;
  int totalCommentPage = 0;

  Future<void> readComment(memoryId) async {
    if(commentPage > totalPage ){
      return;
    }
    commentList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        '$baseURL/Api/Memories/comments?token=$token&memoryId=$memoryId&page=$commentPage&take=15&sortBy=newest',
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['comments'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e)));
        totalCommentPage = response.data['data']['pageCount'];
        debugPrint("Comments: ${response.data}");
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

  TextEditingController commentTextFieldController = TextEditingController();

  Future<void> addComment(memoryId) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.post(
        '$baseURL/Api/Memories/add-comment',
        data: {
          'token': token,
          'memoryId': memoryId,
          'type': 'test',
          'text': commentTextFieldController.text,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response.data);
      if (response.statusCode == 200) {
        commentTextFieldController.clear();
        readComment(memoryId);
        debugPrint("Comments: ${response.data}");
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

  Future<void> deleteComment(commentId) async {
    commentList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.post(
        '$baseURL/Api/Memories/delete-comment',
        data: {'token': token, 'commentId': commentId},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['comments'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e)));
        debugPrint("Comments: ${response.data}");
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

  Future<void> editComment(commentId) async {
    commentList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.post(
        '$baseURL/Api/Memories/edit-comment',
        data: {'token': token, 'commentId': commentId},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['comments'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e)));
        debugPrint("Comments: ${response.data}");
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

  List<FaceEntity> faceList = [];
  int facePage = 1;

  Future<void> addLike({required memoryId}) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final response = await dio.post(
        '$baseURL/Api/Memories/like-memory',
        data: {'token': token.toString(), 'memoryId': memoryId},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      idIsLiked = null;
      if (response.statusCode == 200) ()=> update();

    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }

  void removeLike({required memoryId}) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final response = await dio.post(
        '$baseURL/Api/Memories/remove-like',
        data: {'token': token.toString(), 'memoryId': memoryId},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      idIsLiked = null;
      if (response.statusCode == 200) ()=> update();
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
}
