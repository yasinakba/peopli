import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';

import '../../config/app_string/constant.dart';

class SharedMemoryController extends GetxController {
  final Dio dio = Dio();
  bool loading = false;
  List<MemoryEntity> memoryList = [];

  Future<void> readMemoryId({required id}) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    final response = await dio.get(
      '$baseURL/Api/Memories/$id',
      queryParameters: {
        'token': token,
        'page': 1,
        'take': 15,
        'sortBy': 'newest',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data']['memories'];
      loading = false;
      memoryList.addAll(data.map((e) => MemoryEntity.fromJson(e)));
      update();
    }
  }
}
