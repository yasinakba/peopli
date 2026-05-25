import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_route/route_names.dart';
import 'controllers/splash_controller.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SplashController(),);
      Get.find<SplashController>().splashRoute(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          child: Image(
            image: AssetImage('assets/images/png/Logo.gif'),
          ),
        ),
      ),
    );
  }
}
