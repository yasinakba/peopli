import 'package:get/get.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';

class UploadBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(UploadController());
  }

}