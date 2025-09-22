import 'package:get/get.dart';

import '../../../features/home_screen/controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }

}