import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/features/heart/heart_controller.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_jpg.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';
import '../create_person/entity/face_entity.dart';
import '../first_screen/controller/first_controller.dart';
import '../first_screen/entity/memory_entity.dart';
import '../first_screen/widget/comment_post.dart';
import '../first_screen/widget/post_first_screen.dart';
import '../login/controller/login_controller.dart';
import '../profile_screen/controller/profile_controller.dart';

class HeartScreen extends StatefulWidget {

  bool isLiked = false;
  HeartScreen();
  @override
  State<HeartScreen> createState() => _HeartScreenState();
}

class _HeartScreenState extends State<HeartScreen> {
 final HeartController heartController = Get.put(HeartController());
 final ProfileController profileController = Get.put(ProfileController());
 // Future<String> getAddress(latitude,longitude) async {
   // final placemarks = await placemarkFromCoordinates(
   //   latitude!.toDouble(),
   //   longitude!.toDouble(),
   //   localeIdentifier: "en", // force English
   // );
   // if (placemarks.isNotEmpty) {
   //   final place = placemarks.first;
   //   // Build a nice formatted address
   //   return "${place.street}, ${place.locality}, ${place
   //       .administrativeArea}, ${place.country}";
   // }
   // return "Unknown location";
 // }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: GetBuilder<HeartController>(
          initState: (state) {
            Get.lazyPut(() => ProfileController());
            Get.lazyPut(() => HeartController(),);
            Get.lazyPut(() => FirstController(),);
          },
          builder: (controller) {
            return  SizedBox(
              height: 690.h,
              width: 360.w,
              child: PagingListener(
                controller: controller.pagingMemoryController,
                builder: (context, state, fetchNextPage) =>
                    PagedListView<int, dynamic>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<dynamic>(
                        itemBuilder: (context, memory, index) {
                          final face = Get.find<FirstController>().faceList.firstWhere(
                                (i) => i.id == memory.faceId,
                            orElse: () => FaceEntity(), // Return empty face if not found
                          );
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: PostFirstScreen(
                              memory,
                              index,
                              face,
                            ),
                          );
                        },
                        // Optional placeholders for better UX
                        firstPageProgressIndicatorBuilder:
                            (context) => Padding(
                          padding: EdgeInsets.all(10),
                          child: SpinKitFadingCube(
                            duration: Duration(seconds: 1),
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                              );
                            },
                          ),
                        ),
                        newPageProgressIndicatorBuilder: (context) =>
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: SpinKitFadingCube(
                                duration: Duration(seconds: 1),
                                itemBuilder:
                                    (
                                    BuildContext context,
                                    int index,
                                    ) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: index.isEven
                                          ? Colors.green
                                          : Colors.blue,
                                    ),
                                  );
                                },
                              ),
                            ),
                        noItemsFoundIndicatorBuilder: (context) =>
                        const Center(
                          child: Text("No memories found."),
                        ),
                      ),
                    ),
              ),
            );
      }),
    );
  }
}