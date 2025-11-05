import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/profile_screen/entity/user_entity.dart';

import '../../create_person/entity/face_entity.dart';
import '../../first_screen/entity/comment_entity.dart';
import '../../first_screen/entity/memory_entity.dart';

class ProfileController extends GetxController {
  final dio = Dio();
  @override
  void onInit() {
    super.onInit();
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
        '$baseURL/Api/Account',
        queryParameters: {
          'token': token.toString(),
        },
      );

      final data = response.data['data'];

      if (data != null) {
        if (data is Map<String, dynamic>) {
            final user = UserEntity.fromJson(data);
            currentUser.add(user);
            debugPrint("✅ Single user added: ${user.username}");
        } else if (data is List) {
          // Multiple users
          for (var item in data) {
            if (item is Map<String, dynamic>) {
              try {
                final user = UserEntity.fromJson(item);
                currentUser.add(user);
              } catch (e, st) {
                debugPrint("❌ Error parsing user in list: $e");
                debugPrint("$st");
              }
            } else {
              debugPrint("❌ Unexpected item type in list: ${item.runtimeType}");
            }
          }
          debugPrint("✅ Added ${currentUser.length} users from list");
        } else {
          debugPrint("❌ Unexpected data type: ${data.runtimeType}");
        }

        update();
      } else {
        debugPrint("❌ Data is null");
      }

    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching account: $e");
      debugPrint(stacktrace.toString());
    }
  }
  List<MemoryEntity> memoryList = [];
  int memoryPage = 1;
  late TabController tabController;
  List<UserEntity> currentUser = [];
  late final pagingMemoryController = PagingController<int,dynamic>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreMemories(pageKey),
  );
  bool isLoadingMemories = false;
  bool isLoadingFaces= false;
  int totalPage = 0;
  int totalFacePage = 0;
  Future<List<MemoryEntity>> readMoreMemories(pageKey) async {
    if(pageKey > totalPage) return[];
      memoryPage++;
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        if (token == null) {
          debugPrint("⚠️ No token found in SharedPreferences");
          return memoryList;
        }

        final response = await dio.get(
          '$baseURL/Api/Memories',
          queryParameters: {
            'token': token,
            'page': pageKey,
            'take': 15,
            'sortBy': 'closet',
            'userId':currentUser.first.id,
          },
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ),
        );
        if (response.statusCode == 200) {
          final List<dynamic> data = response.data['data']['memories'];
          totalPage = response.data['data']['pageCount'];
          isLoadingMemories = false;
          memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e)));
          update();
          return memoryList;
        } else {
          debugPrint(
              "❌ Error: ${response.statusCode} -> ${response.statusMessage}");
          return memoryList;
        }
      } catch (e, stacktrace) {
        debugPrint("🔥 Exception while fetching memories: $e");
        debugPrint(stacktrace.toString());
        return memoryList;
      } finally {
        if (!isClosed) isLoadingMemories = false;
      }
  }
  Future<void> readFace() async{
    isLoadingFaces = true;
    faceList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        '$baseURL/Api/Faces?token=$token&page=1&take=15&sortBy=closest',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['faces'];
        faceList.addAll(data.map((e) => FaceEntity.fromJson(e),));
        debugPrint("Faces: ${response.data}");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  Future<List<FaceEntity>> readMoreFace(pageKey) async{
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
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        facePage = response.data['data']['pageCount'];
        List<dynamic> data = response.data['data']['faces'];
        faceList.addAll(data.map((e) => FaceEntity.fromJson(e),));
        debugPrint("Faces: ${response.data}");
        isLoadingFaces =false;
        update();
        return faceList;
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
        return faceList;
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
      return faceList;

    }
  }
  List<CommentEntity> commentList = [];
  int commentPage = 1;
  Future<void> readComment(memoryId) async{
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
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['comments'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e),));
        debugPrint("Comments: ${response.data}");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  TextEditingController commentTextFieldController = TextEditingController();
  Future<void> addComment(memoryId) async{
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
          'token':token,
          'memoryId':memoryId,
          'type':'test',
          'text':commentTextFieldController.text,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        readComment(memoryId);
        debugPrint("Comments: ${response.data}");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  Future<void> deleteComment(commentId) async{
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
        data: {
          'token':token,
          'commentId':commentId,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['comments'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e),));
        debugPrint("Comments: ${response.data}");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  Future<void> editComment(commentId) async{
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
        data: {
          'token':token,
          'commentId':commentId,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['comments'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e),));
        debugPrint("Comments: ${response.data}");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  List<FaceEntity> faceList = [];
  int facePage = 1;

  Future<void> addLike(memoryId) async{
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
        data: {
          'token':token.toString(),
          'memoryId':memoryId,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response.data['data']);
      if (response.statusCode == 200) {
        // ✅ Success
        List<dynamic> data = response.data['data']['faces'];
        commentList.addAll(data.map((e) => CommentEntity.fromJson(e),));
        debugPrint("Faces: ${response.data}");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  Future<void> removeLike(memoryId) async{
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
        data: {
          'token':token,
          'memoryId':memoryId,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Success

        debugPrint("Faces: ${response.data}");
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