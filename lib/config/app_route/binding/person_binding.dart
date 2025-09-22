import 'package:get/get.dart';

import '../../../features/person_screen/controller/person_controller.dart';
class PersonBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(PersonController());
  }

}