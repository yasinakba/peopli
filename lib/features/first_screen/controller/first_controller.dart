import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/first_screen/entity/comment_entity.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../../feature_job_and_education/controller/education_cotnroller.dart';
import '../../feature_job_and_education/controller/job_controller.dart';
import '../../feature_location/controller/location_controller.dart';

class FirstController extends GetxController {
  final dio = Dio();
  int memoryPage = 1;
  List<MemoryEntity> memoryList = [];
  late ScrollController scrollMemoryController;
  bool isLoadingMemories = false;
  int lastLoadedPage = 0;
  ScrollController scrollFaceController = ScrollController();
  final threshold = 100.0;
  @override
 void onInit() {
    super.onInit();
    readFace();
    readMemories();
    scrollMemoryController = ScrollController();
    Get.lazyPut<LocationController>(() => LocationController());
    Get.lazyPut<JobDropDownController>(() => JobDropDownController());
    Get.lazyPut<EducationController>(() => EducationController());
    Get.lazyPut<ProfileController>(() => ProfileController());

    // Defer API calls until the next frame
    Future.delayed(Duration.zero, () {
      Get.find<LocationController>().getCity(null);
      Get.find<LocationController>().getCountry();
      Get.find<JobDropDownController>().getJob();
      Get.find<EducationController>().getEducation();
      Get.find<ProfileController>().getCurrentAccount();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollMemoryController.addListener(() {
        if (!scrollMemoryController.hasClients) return;

        final position = scrollMemoryController.position;
        if (position.pixels >= position.maxScrollExtent - 200) {
          if (!isLoadingMemories) {
            isLoadingMemories = true;
            try {
              readMoreMemories(); // fetch next page
              if (!isClosed) {
                memoryPage++;
                update(); // update UI safely
              }
            } finally {
              if (!isClosed) isLoadingMemories = false;
            }
          }
        }
      });
    });

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
        'https://api.peopli.ir/Api/Memories',
        queryParameters: {
          'token':token,
          'page': 1,
          'take': 4,
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


  // Future<void> readMoreMemories() async {
  //   try {
  //     final preferences = await SharedPreferences.getInstance();
  //     final token = preferences.getString('token');
  //     await Future.delayed(const Duration(seconds: 2)); // simulate API call
  //     // update UI safely
  //
  //     if (token == null) {
  //       debugPrint("⚠️ No token found in SharedPreferences");
  //       return;
  //     }
  //
  //     final response = await dio.get(
  //       'https://api.peopli.ir/Api/Memories',
  //       queryParameters: {
  //         'token':token,
  //         'page': memoryPage,
  //         'take': 15,
  //         'sortBy': 'closet',
  //       },
  //       options: Options(
  //         headers: {
  //           'Accept': 'application/json',
  //         },
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // ✅ Success
  //     List<dynamic> data = response.data['data']['memories'];
  //     memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e),));
  //     debugPrint("Memories: ${response.data}");
  //     if (Get.isRegistered<FirstController>()) {
  //       update(); // or use Rx variables
  //     }
  //     } else {
  //       debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
  //     }
  //   } catch (e, stacktrace) {
  //     debugPrint("🔥 Exception while fetching memories: $e");
  //     debugPrint(stacktrace.toString());
  //   }
  // }
  Future<void> readMoreMemories() async {
    if (isLoadingMemories) return; // prevent multiple triggers
    isLoadingMemories = true;

    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      await Future.delayed(const Duration(seconds: 2)); // simulate API

      final response = await dio.get(
        'https://api.peopli.ir/Api/Memories',
        queryParameters: {
          'token': token,
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
        final List<dynamic> data = response.data['data']['memories'];

        // Append to memory list safely
        memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e)));

        debugPrint("Memories loaded: ${data.length}");

        // ✅ Update UI only if controller is still alive
        if (!isClosed) {// increment page only after successful fetch
          update();
        }
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
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
  List<FaceEntity> faceList = [];
  int facePage = 1;
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