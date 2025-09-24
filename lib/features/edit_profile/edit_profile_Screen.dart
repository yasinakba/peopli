import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_jpg.dart';

import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../create_account/widget/custom_password_controller.dart';
import '../create_person/widget/textField_create.dart';
import 'conteoller/edit_profile_controller.dart';

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
              builder: (controller) => Padding(
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
                              ? DecorationImage(
                                  image: AssetImage(AppAssetsJpg.imagePerson),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: FileImage(controller.pickedFile!),
                                  fit: BoxFit.cover,
                                ),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 292.w,
                      child: Column(
                        children: [
                          //En && AddPhotoes
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
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
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 5),
                                //   child: TextFieldCreateAccount(labelText: 'UserNAme'),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 5),
                                //   child: TextFieldCreateAccount(labelText: 'Password',),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFieldCreate(
                                    labelText: 'Date of birth',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //location
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 10),
                              child: Text(
                                "Home Location :",
                                style: appThemeData.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 220.w,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 5,
                                  ),
                                  child: Text(
                                    "(2005-now) Avenue 13, Bond Pavilion, Mercury St., Paris, France",
                                    maxLines: 2,
                                    style: appThemeData.textTheme.bodySmall,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    controller.openDialogLocation(context);
                                  },
                                  child: Text(
                                    'Add',
                                    style: appThemeData.textTheme.labelLarge!
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
                                Get.toNamed(NamedRoute.routeLoginScreen);
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
