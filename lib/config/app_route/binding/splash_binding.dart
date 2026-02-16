import 'package:get/get.dart';
import 'package:test_test_test/config/network_controller.dart';
import 'package:test_test_test/features/feature_location/controller/location_controller.dart';

import '../../../features/profile_screen/controller/profile_controller.dart';
import '../../../features/splashscreen/controllers/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(LocationController());
    Get.put(NetworkController(),permanent: true);
    Get.put(ProfileController(),permanent: true);
  }

}