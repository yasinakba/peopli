// import 'package:test_test_test/config/app_route/route_names.dart';
// import 'package:uni_links/uni_links.dart';
// import 'dart:async';
// import 'package:get/get.dart';
//
// void initDeepLinkListener() {
//   // For app already running
//   linkStream.listen((String? link) {
//     if (link != null) {
//       _handleLink(link);
//     }
//   });
//
//   // For app launched by link
//   getInitialLink().then((String? link) {
//     if (link != null) {
//       _handleLink(link);
//     }
//   });
// }
//
// void _handleLink(String link) {
//   Uri uri = Uri.parse(link);
//   if (uri.scheme == 'peopli') {
//     String memoryId = uri.pathSegments.first;
//     // Navigate to memory page
//     Get.toNamed(NamedRoute.routeSharedMemory,arguments: memoryId);
//   }
// }
