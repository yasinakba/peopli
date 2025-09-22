import 'package:get/get.dart';

import '../../../features/first_screen/controller/first_controller.dart';

class FirstBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(FirstController());
  }
  
}