import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/app_string/constant.dart';

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
    splashRoute();
  }

  void _loadInitialData() {
    Get.find<LocationController>().getCity(null);
    Get.find<LocationController>().getCountry();
    Get.find<JobDropDownController>().getJob();
    Get.find<EducationController>().getEducation();
  }

  Future<void> splashRoute() async {
    await Future.delayed(const Duration(seconds: 3));

    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? '';

    if (token.isEmpty) {
      Get.offAllNamed(NamedRoute.routeLoginScreen);
    } else {
      Get.find<ProfileController>().getCurrentAccount();
      Get.offAllNamed(NamedRoute.routeHomeScreen);
    }
  }
}

