import 'package:get/get.dart';

import '../../../features/splashscreen/controllers/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }

}