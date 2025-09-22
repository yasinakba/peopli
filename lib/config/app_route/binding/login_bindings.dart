import 'package:get/get.dart';

import '../../../features/splashscreen/controllers/login_controller.dart';



class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginConteoller());
  }

}