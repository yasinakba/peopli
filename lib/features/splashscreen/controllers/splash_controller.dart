


import 'package:get/get.dart';
import '../../../config/app_string/constant.dart';

import '../../../config/app_route/route_names.dart';

class SplashController extends GetxController{

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkInternet();
    splashRoute();

  }

   splashRoute(){
     Future.delayed(Duration(seconds: 3)).then((value) => Get.toNamed(NamedRoute.routeLoginScreen));
   }

}