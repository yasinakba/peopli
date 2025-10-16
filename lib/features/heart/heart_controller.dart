import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';


import '../first_screen/entity/comment_entity.dart';
import '../first_screen/entity/memory_entity.dart';


class HeartController extends GetxController{
  List<MemoryEntity> memoryList = [];
  int memoryPage = 1;
  List<FaceEntity> faceList =[];
  ScrollController scrollMemoryController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    readFace();
    readMemories();


    scrollMemoryController.addListener(() {
      if (scrollMemoryController.position.pixels >=
          scrollMemoryController.position.maxScrollExtent) {
        memoryPage++;
        readMoreMemories();
      }
    });
  }
  Future<void> readMemories() async {
    memoryList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memories',
        queryParameters: {
          'token':token,
          'page': 1,
          'take': 15,
          'sortBy': 'closet',
        },
        options: Options(
          headers: {
            // 'Accept': 'application/json',
          },
        ),
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
  Future<void> readFace() async{
    faceList.clear();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Faces?token=$token&page=1&take=15&sortBy=closest',
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

  final dio = Dio();
  Future<void> readMoreMemories() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memories',
        queryParameters: {
          'token':token,
          'page': memoryPage,
          'take': 15,
          'sortBy': 'closet',
        },
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
          headers: {
            'Accept': 'application/json',
          },
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
    commentList.clear();
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
          'text':commentTextFieldController.text,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
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
          headers: {
            'Accept': 'application/json',
          },
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
          headers: {
            'Accept': 'application/json',
          },
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
  Future<void> readMoreFace() async{
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final response = await dio.get(
        'https://api.peopli.ir/Api/Faces?token=$token&page=$facePage&take=15&sortBy=closest',
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
          headers: {
            'Accept': 'application/json',
          },
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
          headers: {
            'Accept': 'application/json',
          },
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