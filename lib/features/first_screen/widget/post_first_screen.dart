import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_png.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../login/controller/login_controller.dart';
import 'comment_post.dart';

class PostFirstScreen extends StatefulWidget {
  final MemoryEntity memory;
  final int index;
  final FaceEntity face;
  bool isLiked = false;

  PostFirstScreen(this.memory, this.index, this.face);

  @override
  State<PostFirstScreen> createState() => _PostFirstScreenState();
}

class _PostFirstScreenState extends State<PostFirstScreen> {
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    if (!Get.isRegistered<FirstController>()) {
      Get.put(FirstController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ProfileController profileController = Get.find<ProfileController>();
    return GetBuilder<FirstController>(
      initState: (state) {
        Get.lazyPut(() => ProfileController());
        Get.lazyPut(() => FirstController());
      },
      builder: (controller) {
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
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
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
                              widget.face.name ??'null',
                              style: appThemeData.textTheme.headlineLarge,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              widget.memory.text ?? '',
                              style: appThemeData.textTheme.bodyLarge,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              // "${m} - now",
                              "${widget.face.birthdate.toString()} -now",
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
                              backgroundImage: NetworkImage(
                                "$baseImageURL/${widget.face.avatar??''}",
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
              //post
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      bottom: 5,
                    ),
                    child: GestureDetector(
                      child: SizedBox(
                        width: 44.w,
                        height: 44.h,
                        child: profileController.currentUser.isEmpty
                            ? const CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage(
                                  AppAssetsPng.iconPerson,
                                ),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                  "$baseImageURL/${profileController.currentUser.first.avatar}",
                                ),
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
                            widget.memory.user??'null',
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
                    widget.memory.title??'null',
                    maxLines: 3,
                    style: appThemeData.textTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 5,
                ),
                child: SizedBox(
                  width: 293.w,
                  height: 141.h,
                  child: widget.memory.media != null
                      ? Image.network(
                          'https://api.peopli.ir/uploads/${widget.memory.media?.split('/').last}',
                          fit: BoxFit.fitWidth,
                        )
                      : Image.network(
                          'https://api.peopli.ir/uploads/usericon.png',
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
                            controller.readComment(widget.memory.id);
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(
                                      context,
                                    ).viewInsets.bottom,
                                  ),
                                  child: Container(
                                    height: 450,
                                    child: CommentPost(
                                      memoryEntity: widget.memory,
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
                            widget.memory.commentsCount.toString(),
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
                                  controller.addLike(widget.memory.id);
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
                            widget.memory.likesCount.toString(),
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
                            widget.memory.createdAt.toString(),
                            style: appThemeData.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        );
      },
    );
  }
}
