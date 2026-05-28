import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:test_test_test/features/add_memory/controller/add_memory_controller.dart';
import 'package:test_test_test/features/create_person/controller/create_person_controller.dart';
import 'package:test_test_test/features/edit_person/controller/edit_person_controller.dart';
import 'package:test_test_test/features/feature_location/controller/location_controller.dart';
import 'package:test_test_test/features/share_feature/controller/shared_memory_controller.dart';
import 'package:test_test_test/features/share_feature/page/shared_memory_screen.dart';
import 'package:flutter/foundation.dart';

import 'config/app_theme/app_theme.dart';
import 'features/feature_upload/upload_controller.dart';
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
    if (state.uri.path == '/memories/share/:id') {
      return '/memories/share/:id';
    }
    return '/'; // Return null to let GoRouter handle the current path normally
  },

  routes: [
    // 2. Splash Screen Route
    GoRoute(
      path: '/',
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
    Get.lazyPut(() => SharedMemoryController(),);
    Get.lazyPut(() => UploadController(),);
    Get.lazyPut(() => CreatePersonController(),);
    Get.lazyPut(() => EditPersonController(),);
    Get.lazyPut(() => LocationController(),);
    Get.lazyPut(() => AddMemoryController(),);
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
