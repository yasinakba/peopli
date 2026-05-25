import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:test_test_test/features/share_feature/page/shared_memory_screen.dart';
import 'package:flutter/foundation.dart';

import 'config/app_route/binding/splash_binding.dart';
import 'config/app_route/route_names.dart';
import 'config/app_route/route_screen.dart';
import 'config/app_string/constant.dart';
import 'config/app_theme/app_theme.dart';
import 'features/home_screen/controller/home_controller.dart';
import 'features/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

import 'config/app_route/binding/splash_binding.dart';
import 'config/app_route/route_names.dart';
import 'config/app_route/route_screen.dart'; // Ensure Pages is exported here
import 'config/app_theme/app_theme.dart';
import 'features/home_screen/controller/home_controller.dart';
import 'features/splashscreen/splashscreen.dart';

// Define your base URL or constant if needed
// const String baseURL = 'https://yourdomain.com';

void main() {
  runApp(const MyApp());
}

// 1. Define Router Globally
final router = GoRouter(
  // 1. Fix the redirect logic
  redirect: (context, state) {
    // If the user opens the app normally (path is '/'), redirect to splash
    // Just return the path string. GoRouter will handle the navigation.
    if (state.uri.path == '/') {
      return '/SplashScreen';
    }
    return '/memories/share/:id'; // Return null to let GoRouter handle the current path normally
  },

  routes: [
    // 2. Splash Screen Route
    GoRoute(
      path: '/SplashScreen',
      builder: (context, state) => const SplashScreen(),
    ),

    // 3. Deep Link Route: Shared Memory
    GoRoute(
      path: '/memories/share/:id',
      builder: (context, state) {
        final String? id = state.pathParameters['id'];

        if (id == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid Link: Missing ID')),
          );
        }

        return SharedMemoryScreen(id: id);
      },
    ),
  ],
);


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize HomeController once at the root
    Get.put(HomeController());

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: appThemeData,
          darkTheme: darkAppThemeData,
          themeMode: Get.find<HomeController>().theme, // Ensure this is defined in route_screen.dart
        );
      },
    );
  }
}

class SharedMyApp extends StatelessWidget {
  const SharedMyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize HomeController once at the root
    Get.put(HomeController());

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: appThemeData,
          darkTheme: darkAppThemeData,
          themeMode: Get.find<HomeController>().theme,
          initialBinding: SplashBinding(),
          getPages: Pages.pages, // Ensure this is defined in route_screen.dart
        );
      },
    );
  }
}
