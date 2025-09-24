import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';

import '../entity/education_entity.dart';

class EducationController extends GetxController{
  final dio = Dio();

  List<EducationEntity> educationList = [];
  List<String> educationName = [];
  Future<void> getEducation() async {
    try {
      final response = await dio.get(
        "https://api.peopli.ir/Api/Faces/face-educations?page=1&take=15&sortBy=latest",
      );
      if(response.statusCode == 200 && response.data['status'] == 'ok'){
      List<dynamic> data = response.data['data']['educations'];
      educationList.addAll(data.map((item) => EducationEntity.fromJson(item)));
      educationName.addAll(educationList.map((e) => e.name ?? ''));
      CreateAccountController.selectedEducation = educationList[0];
      update();
      }
    } on DioException catch (e) {
      print("GET error: ${e.response?.statusCode} - ${e.message}");
    }
  }
}