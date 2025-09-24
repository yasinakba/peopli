import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../entity/education_entity.dart';

class EducationController extends GetxController{
  final EducationController jobDropdownController = Get.put(
      EducationController());
  final dio = Dio();

  List<EducationEntity> educationList = [];
  List<String> educationName = [];
  Future<void> getEducation() async {
    try {
      final response = await dio.get(
        "https://api.peopli.ir/Api/Faces/face-educations?page=1&take=15&sortBy=latest",
      );
      List<dynamic> data = response.data['data']['educations'];
      educationList.addAll(data.map((item) => EducationEntity.fromJson(item)));
      educationName.addAll(educationList.map((e) => e.name ?? ''));
    } on DioException catch (e) {
      print("GET error: ${e.response?.statusCode} - ${e.message}");
    }
  }
}