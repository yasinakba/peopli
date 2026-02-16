import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:test_test_test/features/share_feature/shared_memory_screen.dart';
import 'package:flutter/foundation.dart';

import 'config/app_route/binding/splash_binding.dart';
import 'config/app_route/route_names.dart';
import 'config/app_route/route_screen.dart';
import 'config/app_theme/app_theme.dart';
import 'features/home_screen/controller/home_controller.dart';
import 'features/splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp.router(routerConfig: router,));
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

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyApp(),
    ),  GoRoute(
      path: NamedRoute.routeSharedMemory,
      builder: (context, state) => ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          HomeController homeController = Get.put(HomeController());
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appThemeData,
            themeMode: homeController.theme,
            darkTheme: darkAppThemeData,
            initialRoute: NamedRoute.routeSplashScreen,
            initialBinding: SplashBinding(),
            getPages: Pages.pages,
            home: SharedMemoryScreen(),
          );
        },
      ),
    ),
  ],
);
