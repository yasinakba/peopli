import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/app_key_local_storage.dart';
import 'package:test_test_test/features/home_screen/controller/home_controller.dart';
import 'package:test_test_test/features/home_screen/home_screen.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';
import 'package:test_test_test/features/login/login_screen.dart';
import 'package:test_test_test/features/person_screen/controller/person_controller.dart';

import '../../../config/app_route/route_names.dart';
import '../../feature_job_and_education/controller/education_cotnroller.dart';
import '../../feature_job_and_education/controller/job_controller.dart';
import '../../feature_location/controller/location_controller.dart';
import '../../profile_screen/controller/profile_controller.dart';
class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<LocationController>(() => LocationController());
    Get.lazyPut<JobDropDownController>(() => JobDropDownController());
    Get.lazyPut<EducationController>(() => EducationController());
    _loadInitialData();

  }

  @override
  void onReady() {
    super.onReady();
  }

  void _loadInitialData() {
    Get.find<LocationController>().getCity(null);
    Get.find<LocationController>().getCountry();
    Get.find<JobDropDownController>().getJob();
    Get.find<EducationController>().getEducation();
  }

  Future<void> splashRoute({context}) async {
    await Future.delayed(const Duration(seconds: 3));

    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(AppKeyLocalStorage.keyToken) ?? '';

    if (token.isEmpty) {
      Get.lazyPut(() => LoginController());
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    } else {
      Get.lazyPut(() => ProfileController());
      Get.lazyPut(() => HomeController());
      Get.lazyPut(() => PersonController());
      Get.find<ProfileController>().getCurrentAccount();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }
  }
}

