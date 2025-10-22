import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/education_cotnroller.dart';
import 'package:test_test_test/features/feature_location/controller/location_controller.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_jpg.dart';

import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../create_account/widget/custom_textField.dart';
import '../create_person/widget/textField_create.dart';
import 'controller/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  final EditProfileController editProfileController = Get.put(
    EditProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            GetBuilder<EditProfileController>(
              builder: (controller) =>
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: AppLightColor.elipsFill,
                              image: controller.pickedFile == null
                                  ? DecorationImage(image:NetworkImage("https://api.peopli.ir/uploads/${controller.currentUser.avatar}"),fit: BoxFit.cover)
                                  : DecorationImage(
                                image: FileImage(File(controller.pickedFile!.path)),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100)),
                            ),
                          ),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.updateLanguage(0);
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
                                          onTap: () {controller.updateLanguage(1);},
                                          child: Text(
                                            "FA",
                                            style: controller.textStyleEn(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.uploadImage();
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
                                height: 200.h,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextFieldCreateAccount(
                                        labelText: 'name',
                                        controller: controller.displayController,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFieldCreateAccount(
                                        labelText: 'UserNAme',
                                        controller: controller
                                            .userNameController,),
                                    ),  Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFieldCreateAccount(
                                        labelText: 'Email',
                                        controller: controller
                                            .emailController,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFieldCreateAccount(
                                        labelText: 'Password',
                                        controller: controller
                                            .passwordController,
                                        obSecure: true,),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: 10),
                                      child: Container(
                                        width: 360.w,
                                        height: 32.h,
                                        padding: EdgeInsetsDirectional.only(
                                          start: 10.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              25),
                                          border: Border.all(
                                              color: Colors.black),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              // controller.selectedDate != null
                                              //     ? DateFormat(
                                              //   'yyyy/MM/dd – HH:mm',
                                              // ).format(
                                              //   controller.selectedDate!,
                                              // )
                                              //     : "No date selected",            controller.selectedDate != null
                                                  controller.selectedDate??'',
                                              style:
                                              appThemeData.textTheme.bodySmall,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller.pickDateTime(
                                                    context);
                                              },
                                              icon: Icon(
                                                Icons.calendar_today,
                                                size: 15,
                                                color: Colors.grey,
                                              ),
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),


                              //location
                              GetBuilder<LocationController>(builder: (
                                  controller) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Home Location :",
                                              style: appThemeData.textTheme
                                                  .bodyLarge,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  CreateAccountController
                                                      .openDialogLocation(
                                                      context);
                                                },
                                                child: Text(
                                                  'Add',
                                                  style: appThemeData.textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                    color: AppLightColor
                                                        .fillButton,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          textAlign: TextAlign.start,
                                          "${CreateAccountController
                                              .selectedCountry
                                              .name} ${CreateAccountController
                                              .selectedCity.name ??
                                              'No Selected sitll'}",
                                          style: appThemeData.textTheme
                                              .labelLarge!
                                              .copyWith(
                                            color: AppLightColor.fillButton,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(height: 5.h,),
                              GetBuilder<EducationController>(builder: (controller) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 10),
                                    child: Text(
                                      "Education :",
                                      style: appThemeData.textTheme.bodyLarge,
                                    ),
                                  ),
                                );
                              }),

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
                                        CreateAccountController
                                            .selectedEducation.name ??
                                            "No selectedEducation",
                                        maxLines: 2,
                                        style: appThemeData.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        CreateAccountController
                                            .openDialogEducation(context);
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

                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    controller.editProfile();
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
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
