import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/add_memory/widget/negativ_pasetiv.dart';
import 'package:test_test_test/features/add_memory/widget/textFild_memory.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../create_person/entity/face_entity.dart';
import '../feature_getlocation_fromgps/controller/get_location_controller.dart';
import 'controller/add_memory_controller.dart';

class AddMemoryScreen extends GetView<AddMemoryController> {
  final FaceEntity face = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLightColor.withColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppLightColor.withColor,
        title: Text("Peopli", style: appThemeData.textTheme.displayMedium),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: AppLightColor.rectangleBold,
        ),
      ),
      body: ListView(
        children: [
          GetBuilder<AddMemoryController>(
            initState: (state) {
              Get.lazyPut(() => GetLocationController());
              Get.lazyPut(() => DateController());
            },
            builder: (controller) =>
                Column(
                  children: [
                    //divider
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppLightColor.cancelButtonFill,
                    ),
                    //header
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "$baseImageURL/${face.avatar}"),
                            ),
                          ),
                          SizedBox(
                            width: 125.w,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "${face.name ?? ''} ${face.lastName}",
                                    style: appThemeData.textTheme.headlineLarge,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    face.country ?? 'your country null',
                                    style: appThemeData.textTheme.bodyLarge,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "${face.birthdate?.substring(0, 4) ??
                                        'null'} - now",
                                    style: appThemeData.textTheme.bodyLarge,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    face.homeTown ??
                                        'your homeTown does not exist',
                                    style: appThemeData.textTheme.bodyLarge,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 70.w),
                        ],
                      ),
                    ),
                    //divider
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppLightColor.cancelButtonFill,
                    ),
                    //AddMemory
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            "AddMemory",
                            style: appThemeData.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    //Radio
                    Row(children: [NegativPositive()]),

                    //location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            "Location: ",
                            style: appThemeData.textTheme.bodyLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: InkWell(
                            child: GetBuilder<GetLocationController>(initState: (state) {
                              Get.lazyPut(() => GetLocationController(),);
                            },builder: (logic) {
                              return logic.loading?Container(
                                  width: 250.w,
                                  child: LoadingWidget()):TextFiildMemory(
                                labelText: 'Location',
                                iconT: Icon(Icons.location_on,
                                  color: Colors.green.shade400,),
                                onPressed: () {
                                  controller.getLocationController
                                      .getLocationFromGPS(controller);
                                },
                                controller: controller.locationController,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    //Date
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          Text(
                              'Date:', style: appThemeData.textTheme.bodyLarge),
                          Spacer(),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 10),
                            child: Container(
                              width: 257.w,
                              height: 32.h,
                              padding: EdgeInsetsDirectional.only(start: 10.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.black),
                              ),
                              child: GetBuilder<DateController>(
                                builder: (logic) {
                                  // Safely handle null controller or date
                                  final safeDate = controller.dateController
                                      .selectedDate;
                                  final formattedDate = DateFormat(
                                      'yyyy/MM/dd – HH:mm').format(safeDate);
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        formattedDate,
                                        style: appThemeData.textTheme
                                            .bodySmall ??
                                            const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            controller.dateController
                                                .pickDateTime(context),
                                        icon: const Icon(
                                          Icons.calendar_today,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          Spacer(flex: 2,),
                        ],
                      ),
                    ),
                    //Subject
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 23, top: 20),
                          child: Text(
                            "Subject: ",
                            style: appThemeData.textTheme.bodyLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 25),
                          child: InkWell(
                            child: TextFiildMemory(
                              labelText: 'Subject...',
                              iconT: Icon(Icons.subject),
                              onPressed: () {},
                              controller: controller.subjectController,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //description
                    Padding(
                      padding: const EdgeInsets.only(top: 40, right: 20),
                      child: Container(
                        width: 315.w,
                        height: 119.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppLightColor.strokeRectangleType,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                            controller: controller.textController,
                            maxLines: 8, //or null
                            decoration: InputDecoration.collapsed(
                              hintText: "text...",
                            ),
                          ),
                        ),
                      ),
                    ),

                    //image
                    GetBuilder<UploadController>(builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, top: 40),
                            child: SizedBox(
                              width: 180.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "Add photo or video:",
                                    style: appThemeData.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    controller.selectedImage.value,
                                    style: appThemeData.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 45, top: 40),
                            child: SizedBox(
                              width: 90.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.uploadImage();
                                    },
                                    child: Text(
                                      "Add ",
                                      style: appThemeData.textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, right: 50),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomElevatedButton(
                          onPressed: () {
                            controller.addMemory(face.id);
                          },
                          textColor: AppLightColor.withColor,
                          color: AppLightColor.textBlueColor,
                          title: "Submit",
                          height: 35.h,
                          width: 90.w,
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
