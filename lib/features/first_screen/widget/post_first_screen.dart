import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';
import 'package:test_test_test/features/profile_screen/controller/profile_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_png.dart';
import '../../../config/app_theme/app_theme.dart';
import 'comment_post.dart';

class PostFirstScreen extends StatefulWidget {
  final MemoryEntity memory;
  final int index;
  final List likeCount;
  IconData? iconLike;
  Color? iconColor;
  PostFirstScreen(this.memory, this.index, this.likeCount);

  @override
  State<PostFirstScreen> createState() => _PostFirstScreenState();
}

class _PostFirstScreenState extends State<PostFirstScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<FirstController>(
      initState: (state) {
        Get.lazyPut(() => FirstController());
      },
      builder: (controller) {
        return Container(
          alignment: AlignmentDirectional.topStart,
          width: 345.w,
          // height: 450.h,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              widget.memory.username ?? 'null',
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
                              "${widget.memory.faceBirthdate.toString().substring(0, 4)} -now",
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
                          CircleAvatar(
                            radius: 42,
                            backgroundImage: NetworkImage(
                              "$baseImageURL/${widget.memory.faceAvatar ?? 'noavatar.png'}",
                            ),
                          ),
                          Ink(
                            padding: const EdgeInsets.only(left: 50),
                            width: 20.w,
                            height: 20.w,
                            child: Text("2.0"),
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
                  Container(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      bottom: 5,
                    ),
                    child: CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(
                        "$baseImageURL/${widget.memory.userAvatar ?? 'noavatar.png'}",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 130.w,
                          child: Text(
                            widget.memory.face ?? 'null',
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 3,
                ),
                child: AutoSizeText(
                  widget.memory.title ?? 'null',
                  maxLines: 3,
                  style: appThemeData.textTheme.headlineLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              //Description
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 20,
              //     vertical: 3,
              //   ),
              //   child: GetBuilder<FirstController>(
              //     id: 'location_${memory.id}',
              //     builder: (logic) {
              //       return Row(
              //         children: [
              //           Icon(IconsaxPlusBold.location),
              //           controller.locationLoading
              //               ? LoadingWidget()
              //               : AutoSizeText(
              //                   controller.getLocation(memory.lat, memory.lng, memory.id,).toString(),
              //                   maxLines: 3,
              //                   style: appThemeData.textTheme.headlineLarge,
              //                   textAlign: TextAlign.start,
              //                 ),
              //         ],
              //       );
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 3,
                ),
                child: AutoSizeText(
                  widget.memory.text ?? 'null',
                  maxLines: 3,
                  style: appThemeData.textTheme.headlineLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                width: 370.w,
                height: 141.h,
                child: Image.network(
                  '$baseImageURL/${widget.memory.media ?? 'usericon.png'}',
                  fit: BoxFit.fitWidth,
                ),
              ),

              //comment Like && share
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.readComment(widget.memory.id);
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(
                                      context,
                                    ).viewInsets.bottom,
                                  ),
                                  height: 450,
                                  child: CommentPost(
                                    memoryEntity: widget.memory,
                                    isFromProfile: false,
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
                    Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                          height: 30.w,
                          child: IconButton(
                            onPressed: () {
                              // controller.idIsLiked =
                              //     widget.memory.id?.toInt() ?? -1;
                              if (widget.iconColor == Colors.grey.shade600 ||
                                  widget.iconColor == null) {
                                controller.addLike(memoryId: widget.memory.id);
                                setState(() {
                                  widget.likeCount[widget.index]++;
                                  widget.iconColor = Colors.green.shade400;
                                  widget.iconLike = IconsaxPlusBold.heart;
                                });
                              } else if (widget.iconColor ==
                                  Colors.green.shade400) {
                                controller.removeLike(
                                  memoryId: widget.memory.id,
                                );
                                controller.isLiked = false;
                                setState(() {
                                  widget.likeCount[widget.index]--;
                                  widget.iconLike = IconsaxPlusLinear.heart;
                                  widget.iconColor = Colors.grey.shade600;
                                });
                              }
                            },
                            icon: Icon(
                              widget.iconLike ?? IconsaxPlusLinear.heart,
                              size: 17.sp,
                              color: widget.iconColor ?? Colors.grey.shade400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            widget.likeCount[widget.index].toString(),
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
                            // getMemoryShared(id: widget.memory.id);
                            final link =
                                'peopli:///memory/shared/${widget.memory.id}';
                            Share.share('Check this memory: $link');
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
              SizedBox(height: 5.h),
            ],
          ),
        );
      },
    );
  }
}
