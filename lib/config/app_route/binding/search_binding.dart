import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/search_screen/controller/search_bottom_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(SearchBottomController());
  }

}