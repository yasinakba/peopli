import 'package:get/get.dart';

import '../../../features/edit_person/controller/edit_person_controller.dart';

class PersonEditBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(EditPersonController());
  }

}