import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:flutter/foundation.dart';

import '../first_screen/entity/memory_entity.dart';
import '../profile_screen/entity/comment_entity.dart';


class HeartController extends GetxController{
  TextEditingController commentTextFieldController = TextEditingController();
  final dio = Dio();
  List<CommentEntity> commentList = [];
  List<MemoryEntity> memoryList = [];
  late final pagingMemoryController = PagingController<int,dynamic>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => readMoreMemories(pageKey),
  );
  int commentPage = 1;
  int totalMemoryPage = 1;
  bool isLoadingMemories = false;

  // For debugPrint

// Assuming these are defined in your controller
// List<MemoryEntity> memoryList = [];
// List<CommentEntity> commentList = [];
// int totalMemoryPage = 0;
// bool isLoadingMemories = false;
// int commentPage = 1;
// bool isClosed = false;
// Dio dio = Dio();
// String baseURL = 'https://your-api.com';

  Future<List<MemoryEntity>> readMoreMemories(int pageKey) async {
    // 1. Check if we already have all pages
    if (pageKey <= totalMemoryPage) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token == null) {
          debugPrint("⚠️ No token found in SharedPreferences");
          return memoryList;
        }

        final response = await dio.get(
          '$baseURL/Api/Memories/likes',
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

        if (response.statusCode == 200) {
          // ✅ SAFE: Check if data exists and is a Map
          final dynamic responseData = response.data;
          if (responseData == null || responseData['data'] == null) {
            debugPrint("⚠️ API returned null data");
            throw Exception();
          }

          final dynamic data = responseData['data'];

          // ✅ SAFE: Check if 'memories' exists and is a List
          final dynamic memoriesData = data['memories'];
          if (memoriesData == null || memoriesData is! List) {
            debugPrint("⚠️ No memories list found in response");
            throw Exception();
          }

          // ✅ SAFE: Map only if it's a valid list
          final List<MemoryEntity> newMemories = memoriesData
              .whereType<Map<String, dynamic>>() // Ensure items are maps
              .map((e) => MemoryEntity.fromJson(e))
              .toList();

          // Update page count safely
          if (data['pageCount'] != null) {
            totalMemoryPage = data['pageCount'];
          }

          isLoadingMemories = false;
          memoryList.addAll(newMemories);
          update();
          return memoryList;
        } else {
          debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
          throw Exception();
        }
      } catch (e, stacktrace) {
        debugPrint("🔥 Exception while fetching memories: $e");
        debugPrint(stacktrace.toString());
        throw Exception();
      } finally {
        if (!isClosed) isLoadingMemories = false;
      }
    }
    return [];
  }

  Future<void> readComment(int memoryId) async {
    commentList.clear();
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        '$baseURL/Api/Memories/comments',
        queryParameters: {
          'token': token,
          'memoryId': memoryId,
          'page': commentPage,
          'take': 15,
          'sortBy': 'latest',
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        // ✅ SAFE: Check structure
        if (responseData == null || responseData['data'] == null) {
          debugPrint("⚠️ No comments data found");
          return;
        }

        final dynamic data = responseData['data'];
        final dynamic commentsData = data['comments'];

        if (commentsData != null && commentsData is List) {
          commentList.addAll(
            commentsData
                .whereType<Map<String, dynamic>>()
                .map((e) => CommentEntity.fromJson(e))
                .toList(),
          );
          debugPrint("Comments loaded: ${commentList.length}");
        } else {
          debugPrint("⚠️ Comments list is empty or invalid");
        }
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching comments: $e");
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> addComment(int memoryId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

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
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print(response.data);
      if (response.statusCode == 200) {
        // ✅ Success: Refresh comments
        await readComment(memoryId);
        debugPrint("Comment added successfully");
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while adding comment: $e");
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> deleteComment(int commentId) async {
    commentList.clear();
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.post(
        '$baseURL/Api/Memories/delete-comment',
        data: {
          'token': token,
          'commentId': commentId,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        // ✅ SAFE: Check structure
        if (responseData != null && responseData['data'] != null) {
          final dynamic data = responseData['data'];
          final dynamic commentsData = data['comments'];

          if (commentsData != null && commentsData is List) {
            commentList.addAll(
              commentsData
                  .whereType<Map<String, dynamic>>()
                  .map((e) => CommentEntity.fromJson(e))
                  .toList(),
            );
            debugPrint("Comment deleted, updated list");
          }
        }
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while deleting comment: $e");
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> editComment(int commentId) async {
    commentList.clear();
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.post(
        '$baseURL/Api/Memories/edit-comment',
        data: {
          'token': token,
          'commentId': commentId,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        // ✅ SAFE: Check structure
        if (responseData != null && responseData['data'] != null) {
          final dynamic data = responseData['data'];
          final dynamic commentsData = data['comments'];

          if (commentsData != null && commentsData is List) {
            commentList.addAll(
              commentsData
                  .whereType<Map<String, dynamic>>()
                  .map((e) => CommentEntity.fromJson(e))
                  .toList(),
            );
            debugPrint("Comment edited, updated list");
          }
        }
        update();
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while editing comment: $e");
      debugPrint(stacktrace.toString());
    }
  }

}