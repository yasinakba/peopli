import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
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
            Get.find<HeartController>().readFace();
          },
          builder: (controller) {
        return CustomScrollView(
          controller: controller.scrollMemoryController,
          slivers: [SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              MemoryEntity memory = controller.memoryList[index];
              var face = controller.faceList.where((element) => element.id == memory.faceId,).singleOrNull;
              if(face == null){
                return Center(
                  child: Text('Does not exist any Face',style: theme.textTheme.titleMedium,),
                );
              }
              return Container(
                width: 345.w,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    //famous
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, left: 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(NamedRoute.routePersonScreen,arguments: face);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 125.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                          "${face?.name?? 'Face Name'}",
                                      style: appThemeData.textTheme.headlineLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      memory.text ?? '',
                                      style: appThemeData.textTheme.bodyLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      // "${m} - now",
                                      face?.birthdate.toString() ??'birthdate not found',
                                      style: appThemeData.textTheme.bodyLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Avenue 13, Bond Pavilion ...",
                                      style: appThemeData.textTheme.bodyLarge,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 115.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 55.w,
                                    height: 55.h,
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: AssetImage(
                                        AppAssetsJpg.imagePerson,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: SizedBox(
                                      width: 20.w,
                                      height: 20.w,
                                      child: Text("2.0"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //post
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                            bottom: 5,
                          ),
                          child: SizedBox(
                            width: 44.w,
                            height: 44.h,
                            child: profileController.currentUser.isEmpty
                                ? const CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage(
                                  AppAssetsPng.iconPerson),
                            )
                                : CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                "https://api.peopli.ir/uploads/${profileController
                                    .currentUser.first.avatar}",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 130.w,
                                child: Text(
                                 memory.user ?? 'null',
                                  style: appThemeData.textTheme.labelMedium,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                width: 130.w,
                                height: 15,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Icon(
                                    Icons.circle,
                                    color: AppLightColor.negativeFill,
                                    size: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //Description
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: SizedBox(
                        child: AutoSizeText(
                          memory.title ?? 'null',
                          maxLines: 3,
                          style: appThemeData.textTheme.headlineLarge,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    //Location
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 20,
                        bottom: 5,
                        top: 5,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          // FutureBuilder<String>(
                            // future: getAddress(memory.lat,memory.lng),
                            // builder: (context, snapshot) {
                            //   if (snapshot.connectionState ==
                            //       ConnectionState.waiting) {
                            //     return const CircularProgressIndicator();
                            //   } else if (snapshot.hasError) {
                            //     return Text("Error: ${snapshot.error}");
                            //   } else {
                            //     return AutoSizeText(
                            //       snapshot.data ?? 'null',
                            //       maxLines: 3,
                            //       style: appThemeData.textTheme.bodySmall,
                            //       textAlign: TextAlign.start,
                            //     );
                            //   }
                            // },
                          // ),
                        ],
                      ),
                    ),
                    //imagepost
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 5,
                      ),
                      child: SizedBox(
                        width: 293.w,
                        height: 141.h,
                        child: memory.media != null
                            ? Image.network(
                          'https://api.peopli.ir/uploads/${memory.media
                              ?.split('/')
                              .last}',
                          fit: BoxFit.fitWidth,
                        )
                            : Image.asset(
                          AppAssetsJpg.imagePerson,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    //comment Like && share
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //comment
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery
                                              .of(
                                            context,
                                          )
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: Container(
                                          height: 450,

                                          child: CommentPost(
                                            memoryEntity:memory,
                                            isFromProfile: false,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: SizedBox(
                                  width: 17.w,
                                  height: 17.h,
                                  child: Image.asset(
                                    AppAssetsPng.iconComment,
                                    color: AppLightColor.postNavbar,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  memory.commentsCount.toString(),
                                  style: appThemeData.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          //heart
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: 30.w,
                                  height: 30.w,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.isLiked = !widget.isLiked;
                                        controller.addLike(memory.id);
                                      });
                                    },
                                    icon: Icon(
                                      widget.isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 17.sp,
                                      color: widget.isLiked
                                          ? Colors.green.shade400
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  memory.likesCount.toString(),
                                  style: appThemeData.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          //share
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.find<LoginController>().share();
                                },
                                child: SizedBox(
                                  width: 17.w,
                                  height: 17.h,
                                  child: Image.asset(
                                    AppAssetsPng.iconShare,
                                    color: AppLightColor.postNavbar,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //time
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  memory.createdAt.toString(),
                                  style: appThemeData.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }, childCount:controller.memoryList.length),
          ),]
        );
      }),
    );
  }
}