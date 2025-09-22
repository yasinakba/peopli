import 'package:get/get.dart';

import '../../../features/edit_profile/conteoller/edit_profile_controller.dart';
class EditProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }

}