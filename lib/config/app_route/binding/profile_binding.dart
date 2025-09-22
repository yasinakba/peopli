import 'package:get/get.dart';

import '../../../features/profile_screen/controller/profile_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(ProfileController());
  }

}