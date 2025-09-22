import 'package:get/get.dart';

import '../../../features/add_memory/controller/add_memory_controller.dart';


class AddMemoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddMemoryController());
  }

}