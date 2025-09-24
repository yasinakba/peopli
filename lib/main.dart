import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/app_route/binding/splash_binding.dart';
import 'config/app_route/route_names.dart';
import 'config/app_route/route_screen.dart';
import 'config/app_theme/app_theme.dart';
import 'features/home_screen/controller/home_controller.dart';
import 'features/splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appThemeData,
          themeMode: homeController.theme,
          darkTheme: darkAppThemeData,
          initialRoute: NamedRoute.routeSplashScreen,
          initialBinding: SplashBinding(),
          getPages: Pages.pages,
          home: SplashScreen(),
        );
      },
    );
  }
}
