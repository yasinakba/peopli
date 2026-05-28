import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_test_test/config/app_colors/app_colors_light.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/edit_person/widget/edit_gender_person.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';
import 'package:test_test_test/features/edit_person/widget/textField_create.dart';
import '../../config/app_string/app_key_string_ternationalization.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../../config/widgets/date_picker_widget.dart';

import '../create_person/widget/information-Person.dart';
import 'controller/edit_person_controller.dart';

class EditPersonScreen extends StatelessWidget {
  final FaceEntity face;

  const EditPersonScreen({super.key, required this.face});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<EditPersonController>(
        initState: (state) {
          Get.lazyPut(() => EditPersonController(),);
          Get.lazyPut(() => UploadController());
          Get.lazyPut(() => DateController());
        },
        builder: (controller) {
          controller.face = face;
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: GetBuilder<UploadController>(
                  builder: (logic) {
                    return Container(
                      height: 90.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppLightColor.elipsFill,
                        image: logic.pickedFile == null
                            ? DecorationImage(
                          image: NetworkImage(
                            "$baseImageURL/${controller.face?.avatar??''}",
                          ),
                          fit: BoxFit.cover,
                        )
                            : DecorationImage(
                          image: FileImage(File(logic.pickedFile!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 292.w,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.updateLanguage(0);
                                },
                                child: Text(
                                  'EN',
                                  style: controller.textStyleEn(0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5),
                                child: Text("|"),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.updateLanguage(1);
                                },
                                child: Text(
                                  'FA',
                                  style: controller.textStyleEn(1),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.find<UploadController>().uploadImage();
                            },
                            child: Text(
                              "Add Photos",
                              style: appThemeData.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //textField
                    SizedBox(
                      height: 180.h,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFieldCreate(
                              labelText: 'userName',
                              controller: controller.nameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextFieldCreate(
                              labelText: 'Name & Family',
                              controller: controller.familyNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextFieldCreate(
                              labelText: 'Known as',
                              controller: controller.knowAsController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 10),
                            child: Container(
                              width: 290.w,
                              height: 32.h,
                              padding: EdgeInsetsDirectional.only(start: 10.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.black),
                              ),
                              child: GetBuilder<DateController>(
                                builder: (controller) {
                                  final safeDate = controller.selectedDate;
                                  final formattedDate = DateFormat(
                                    'yyyy/MM/dd – HH:mm',
                                  ).format(safeDate);
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formattedDate,
                                        style:
                                        appThemeData.textTheme.bodySmall ??
                                            const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            controller.pickDateTime(context),
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
                        ],
                      ),
                    ),
                    EditGenderPerson(),
                    InformationPerson(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 50,
                        left: 50,
                        top: 20,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomElevatedButton(
                            onPressed: () => Get.back(),
                            textColor: AppLightColor.textBoldColor,
                            color: AppLightColor.cancelButtonFill,
                            title: 'Cancel',
                            height: 29.h,
                            width: 90.w,
                          ),
                          CustomElevatedButton(
                            onPressed: () =>
                                controller.openDialogPerson(context),
                            textColor: AppLightColor.withColor,
                            color: AppLightColor.saveButton,
                            title: 'Save',
                            height: 29.h,
                            width: 90.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
