import 'package:get/get.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';



class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
  }

}