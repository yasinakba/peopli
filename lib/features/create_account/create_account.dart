import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/education_cotnroller.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../../config/widgets/date_picker_widget.dart';
import '../edit_profile/widget/textField_create_account.dart';
import 'controller/create_account_controller.dart';

class CreateAccountScreen extends GetView<CreateAccountController> {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            GetBuilder<CreateAccountController>(
              builder: (controller) {
                if (controller.loading == true) {
                  LoadingWidget();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GetBuilder<UploadController>(builder: (controller) {
                          return Container(
                            height: 130.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: AppLightColor.elipsFill,
                              image: controller.pickedFile == null
                                  ? DecorationImage(image: NetworkImage(
                                  '$baseImageURL/noavatar.png',))
                                  : DecorationImage(image: FileImage(
                                  File(controller.pickedFile!.path,),),
                                fit: BoxFit.cover,
                              ), shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: 292.w,
                        child: Column(
                          children: [
                            //En && AddPhotoes
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.updateLAnguage(0);
                                        },
                                        child: Text(
                                          "EN",
                                          style: controller.textStyleEn(0),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                        ),
                                        child: Text("|"),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.updateLAnguage(1);
                                        },
                                        child: Text(
                                          "FA",
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
                              height: 250.h,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextFieldCreateAccount(
                                      labelText: 'name',
                                      controller: controller.nameController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: TextFieldCreateAccount(
                                      labelText: 'family',
                                      controller: controller.familyController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: TextFieldCreateAccount(
                                      labelText: 'UserNAme',
                                      controller: controller
                                          .userNameController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: TextFieldCreateAccount(
                                      labelText: 'Password',
                                      controller: controller
                                          .passwordController,
                                      obsecure: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: TextFieldCreateAccount(
                                      labelText: 'Confirm Password',
                                      controller: controller
                                          .confirmPasswordController,
                                      obsecure: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        top: 10),
                                    child: Container(
                                      width: 360.w,
                                      height: 32.h,
                                      padding: EdgeInsetsDirectional.only(
                                          start: 10.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: GetBuilder<DateController>(
                                        builder: (controller) {
                                          // Safely handle null controller or date
                                          final safeDate = controller
                                              .selectedDate;
                                          final formattedDate = DateFormat(
                                              'yyyy/MM/dd').format(
                                              safeDate);
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
                                                onPressed: () async {
                                                  controller.pickDateTime(context);
                                                },
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

                            //location
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 10),
                                    child: Text(
                                      "Home Location :",
                                      style: appThemeData.textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 5,
                                        ),
                                        child: Text(
                                          "${CreateAccountController
                                              .selectedCountry
                                              .name ??
                                              ''} ${CreateAccountController
                                              .selectedCity.name ??
                                              "(2005-now) Avenue 13, Bond Pavilion, Mercury St., Paris, France"}",
                                          maxLines: 2,
                                          style: appThemeData.textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          CreateAccountController
                                              .openDialogLocation(context);
                                        },
                                        child: Text(
                                          'Add',
                                          style: appThemeData.textTheme
                                              .labelLarge!
                                              .copyWith(
                                            color: AppLightColor.fillButton,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 10),
                                    child: Text(
                                      "Education",
                                      style: appThemeData.textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    GetBuilder<EducationController>(
                                        builder: (logic) {
                                          return SizedBox(
                                            width: 220.w,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                top: 5,
                                              ),
                                              child: Text(
                                                CreateAccountController
                                                    .selectedEducation
                                                    .name ??
                                                    "(2005-now) Avenue 13, Bond Pavilion, Mercury St., Paris, France",
                                                maxLines: 2,
                                                style: appThemeData.textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          );
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          CreateAccountController
                                              .openDialogEducation(
                                            context,
                                          );
                                        },
                                        child: Text(
                                          'Add',
                                          style: appThemeData.textTheme
                                              .labelLarge!
                                              .copyWith(
                                            color: AppLightColor.fillButton,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: controller.loading?LoadingWidget(): CustomElevatedButton(
                                onPressed: () {
                                  controller.signUp();
                                },
                                textColor: AppLightColor.withColor,
                                color: AppLightColor.textBlueColor,
                                title: "Create",
                                height: 40.h,
                                width: 300.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
