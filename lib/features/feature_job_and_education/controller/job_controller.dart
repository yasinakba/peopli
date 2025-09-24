import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/education_entity.dart';

import '../entity/job_entity.dart';


class JobDropDownController extends GetxController{
  final dio = Dio();
  List<JobEntity> jobList = [];
  List<String> jobName = [];

  /// Simple GET request with error handling
  Future<void> getJob() async {
    try {
      final response = await dio.get(
        "https://api.peopli.ir/Api/Jobs?page=1&take=999&sortBy=latest",
      );
      if(response.statusCode==200){
      List<dynamic> data = response.data['data']['jobs'];
      jobList.addAll(data.map((item) => JobEntity.fromJson(item)));
      jobName.addAll(jobList.map((item)=> item.name??''));
      CreateAccountController.selectedJob = jobList[0];
      update();
      }
    } on DioException catch (e) {
      print("GET error: ${e.response?.statusCode} - ${e.message}");
    }
  }

}