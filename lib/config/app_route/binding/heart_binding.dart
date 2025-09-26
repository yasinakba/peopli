import 'package:get/get.dart';
import 'package:test_test_test/features/heart/heart_controller.dart';

class HeartBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HeartController());
  }

}