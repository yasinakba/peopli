import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/education_cotnroller.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/job_controller.dart';
import 'package:test_test_test/features/feature_location/controller/location_controller.dart';

import '../../../config/app_route/route_names.dart';

class LoginController extends GetxController{
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obSecureText = true;

  share() async {
    await Share.share("com.example.peopli");
  }
  final dio = Dio();
  @override
  void onInit() {
    super.onInit();

    // Register controllers only
    Get.lazyPut<LocationController>(() => LocationController());
    Get.lazyPut<JobDropDownController>(() => JobDropDownController());
    Get.lazyPut<EducationController>(() => EducationController());

    // Defer API calls until the next frame
    Future.delayed(Duration.zero, () {
      Get.find<LocationController>().getCity(null);
      Get.find<LocationController>().getCountry();
      Get.find<JobDropDownController>().getJob();
      Get.find<EducationController>().getEducation();
    });
  }

  Future<void> signIn() async {
    final username = userNameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error","Username or password is empty");
      return;
    }

    try {

      final response = await dio.post(
        "https://api.peopli.ir/Api/login",
        queryParameters: {
          "username": username,
          "password": password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType, // crucial for .NET backend
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', response.data['data']);
        Get.toNamed(NamedRoute.routeHomeScreen);
      } else {
        Get.showSnackbar(GetSnackBar(title: 'Error',message: response.data['data'],duration: Duration(seconds: 2)));
      }
    } on DioException catch (e) {
      Get.snackbar("Error","POST error: ${e.response?.statusCode} - ${e.message}");
    }
  }

}