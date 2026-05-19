import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/app_key_local_storage.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/profile_screen/entity/comment_entity.dart';
import 'package:test_test_test/features/profile_screen/entity/user_entity.dart';

import '../../create_person/entity/face_entity.dart';
import '../../first_screen/entity/memory_entity.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    readMyPerfectComment(1);
    readMyComment(1);

  }

  final dio = Dio();
  bool doesNotAuth = false;
  UserEntity currentUser = UserEntity.UserEntity(
    id: -1,
    educationId: -1,
    role: '',
    token: '',
    username: '',
    displayName: '',
    password: '',
    avatar: '',
    email: '',
    cityId: -1,
    lastKnownLocation: Location(x: 15, y: 18, srid: 45),
    birthdate: '',
    createdAt: '',
  );

  List<MemoryEntity> memoryList = [];
  int memoryPage = 1;
  late TabController tabController;
  late final pagingCommentController = PagingController<int, CommentEntity>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMyPerfectComment(pageKey),
  );
  late final pagingCommentPerfectController =
      PagingController<int, CommentEntity>(
        getNextPageKey: (state) =>
            state.lastPageIsEmpty ? null : state.nextIntPageKey,
        fetchPage: (pageKey) => readMyPerfectComment(pageKey),
      );
  bool isLoadingMemories = false;
  bool isLoadingFaces = false;
  int totalPage = 1;
  int totalFacePage = 1;

  Future<void> getCurrentAccount() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString(AppKeyLocalStorage.keyToken);

      if (token == null || token.isEmpty) {
        doesNotAuth = true;
        update();
        return;
      }

      final response = await dio.get(
        '$baseURL/Api/Account',
        queryParameters: {'token': token},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];

        if (data != null) {
          currentUser = UserEntity.fromJson(data);
          doesNotAuth = false;
          readMoreMemories(1);


        } else {
          doesNotAuth = true;
        }
      } else {
        doesNotAuth = true;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) doesNotAuth = true;
      debugPrint("🔥 Dio Error: ${e.message}");
    } catch (e) {
      debugPrint("🔥 Unexpected Exception: $e");
    } finally {
      update();
    }
  }

  late final pagingMemoryController =  PagingController<int, MemoryEntity>(
    getNextPageKey: (state) =>
    state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreMemories(pageKey),
  );

  Future<List<MemoryEntity>> readMoreMemories(int pageKey) async {
    if (pageKey <= totalPage) {
      try {
        isLoadingMemories = true;
        update();

        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        final response = await dio.get(
          '$baseURL/Api/Memories',
          queryParameters: {
            'token': token,
            'page': pageKey,
            'take': 15,
            'sortBy': 'newest',
            'userId': currentUser.id,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = response.data['data']['memories'];
          totalPage = response.data['data']['pageCount'];

          final items = data.map((e) => MemoryEntity.fromJson(e)).toList();
          memoryList.addAll(items);
          isLoadingMemories = false;
          update();
          return memoryList;
        }
        isLoadingMemories = false;
        update();

        return [];
      } catch (e, stack) {
        Get.snackbar("Error", "🔥 Exception while fetching memories: $e");
        debugPrint(stack.toString());
        return [];
      }
    }
    return [];
  }
  Future<List<FaceEntity>> readMoreFace(pageKey) async {

    if (pageKey <= totalFacePage) {
      isLoadingFaces = true;
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        final response = await dio.get(
          '$baseURL/Api/Faces?token=$token&page=$pageKey&take=15&sortBy=closest',
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );

        if (response.statusCode == 200) {
          facePage = response.data['data']['pageCount'];
          List<dynamic> data = response.data['data']['faces'];
          faceList.addAll(data.map((e) => FaceEntity.fromJson(e)));
          debugPrint("Faces: ${response.data}");
          isLoadingFaces = false;
          update();
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
  List<CommentEntity> myCommentList = [];
  int commentPage = 1;
  int myCommentPage = 1;

  Future<List<CommentEntity>> readMyComment(pageKey) async {
    if (myCommentPage <= pageKey) {
      // Assuming logic is correct here, though typically check against total pages
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        if (token == null) {
          debugPrint("⚠️ No token found in SharedPreferences");
          return [];
        }

        final response = await dio.get(
          '$baseURL/Api/Memories/my-comments?token=$token&page=$pageKey&take=15&sortBy=latest',
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
        print(response.data);
        if (response.statusCode == 200) {
          myCommentPage = response.data['data']['pageCount'];
          List<dynamic> data = response.data['data']['comments'];
          List<CommentEntity> newItems = data
              .map((e) => CommentEntity.fromJson(e))
              .toList();
          myCommentList.addAll(newItems);
          update();
          return newItems;
        } else {
          Get.snackbar('Error', response.statusMessage ?? '');
          return [];
        }
      } catch (e, stacktrace) {
        debugPrint("🔥 Exception while fetching memories: $e");
        debugPrint(stacktrace.toString());
        return [];
      }
    }
    return [];
  }

  Future<List<CommentEntity>> readMyPerfectComment(pageKey) async {
    if (myCommentPage >= pageKey) {
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        if (token == null) {
          debugPrint("⚠️ No token found in SharedPreferences");
          return [];
        }

        final response = await dio.get(
          '$baseURL/Api/Memories/my-comments?token=$token&page=$pageKey&take=15&sortBy=latest',
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );

        if (response.statusCode == 200) {
          myCommentPage = response.data['data']['pageCount'];
          List<dynamic> data = response.data['data']['comments'];
          List<CommentEntity> newItems = data
              .map((e) => CommentEntity.fromJson(e))
              .toList();
          commentList.addAll(newItems);
          update();
          return newItems;
        } else {
          Get.snackbar('Error', response.statusMessage ?? '');
          return [];
        }
      } catch (e, stacktrace) {
        debugPrint("🔥 Exception while fetching memories: $e");
        debugPrint(stacktrace.toString());
        return [];
      }
    }
    return [];
  }

  Future<void> readComment(memoryId) async {
    commentList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        '$baseURL/Api/Memories/comments?token=$token&memoryId=$memoryId&page=$commentPage&take=15&sortBy=latest',
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

      if (response.statusCode == 200) {
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

  Future<void> addLike(memoryId) async {
    commentList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.post(
        '$baseURL/Api/Memories/like-memory',
        data: {'token': token.toString(), 'memoryId': memoryId},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['faces'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e)));
        debugPrint("Faces: ${response.data}");
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

  Future<void> removeLike(memoryId) async {
    commentList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.post(
        '$baseURL/Api/Memories/remove-like',
        data: {'token': token, 'memoryId': memoryId},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        // ✅ Success

        debugPrint("Faces: ${response.data}");
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
