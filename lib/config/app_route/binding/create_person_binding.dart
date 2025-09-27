import 'package:get/get.dart';

import '../../../features/create_person/controller/create_person_controller.dart';

class CreatePersonBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreatePersonController());
  }

}