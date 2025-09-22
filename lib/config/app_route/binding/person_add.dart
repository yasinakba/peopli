import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';


import '../../../features/person_add_memory/controller/person_add_controller.dart';

class PersonAddBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PersonAddController());
  }


}