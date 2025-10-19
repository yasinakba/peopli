import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';


import '../first_screen/entity/comment_entity.dart';
import '../first_screen/entity/memory_entity.dart';


class HeartController extends GetxController{
  final dio = Dio();
  int memoryPage = 1;
  List<MemoryEntity> memoryList = [];
  late final pagingMemoryController = PagingController<int,dynamic>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreMemories(pageKey),
  );
  bool isLoadingMemories = false;
  bool isLoadingFaces= false;
  int lastLoadedPage = 0;
  @override
  void onInit() {
    super.onInit();
    readMemories();
  }


  @override
  void dispose() {
    // scrollMemoryController.dispose();
    super.dispose();
  }
  Future<void> readMemories() async {
    isLoadingMemories = true;
    memoryList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memorie/likes',
        queryParameters: {
          'token':token,
          'page': 1,
          'take': 15,
          'sortBy': 'closet',
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        // ✅ Success
        List<dynamic> data = response.data['data']['memories'];
        memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e),));
        totalPage = response.data['data']['pageCount'];
        isLoadingMemories = false;
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
  int totalPage = 0;
  int totalFacePage = 0;
  Future<List<MemoryEntity>> readMoreMemories(pageKey) async {
    memoryPage++;
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return memoryList;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memorie/likes',
        queryParameters: {
          'token': token,
          'page': pageKey,
          'take': 15,
          'sortBy': 'closet',
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response.data);
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
        'https://api.peopli.ir/Api/Memories/comments?token=$token&memoryId=$memoryId&page=$commentPage&take=15&sortBy=latest',
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
        'https://api.peopli.ir/Api/Memories/add-comment',
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
      print(response.data);
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
        'https://api.peopli.ir/Api/Memories/delete-comment',
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
        'https://api.peopli.ir/Api/Memories/edit-comment',
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
        'https://api.peopli.ir/Api/Memories/like-memory',
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
        'https://api.peopli.ir/Api/Memories/remove-like',
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