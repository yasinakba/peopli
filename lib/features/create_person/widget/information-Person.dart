import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/job_controller.dart';
import 'package:test_test_test/features/feature_location/controller/location_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../controller/create_person_controller.dart';

class InformationPerson extends GetView<CreatePersonController> {
  const InformationPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) =>
          Container(
            width: 300.w,
            height: 220.h,
            decoration: BoxDecoration(
              color: AppLightColor.backgoundPost,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Column(
              children: [
                //location
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
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
                        padding: const EdgeInsets.only(left: 15, top: 5),
                        child: Text(
                          CreateAccountController.selectedCountry.name !=
                              null &&
                              CreateAccountController.selectedCity.name !=
                                  null
                              ? "${CreateAccountController.selectedCountry
                              .name ?? ''} ${CreateAccountController
                              .selectedCity.name ?? ''}"
                              : "(2005-now) Avenue 13, Bond Pavilion, Mercury St., Paris, France",
                          maxLines: 2,
                          style: appThemeData.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          CreateAccountController.openDialogLocation(context);
                        },
                        child: Text(
                          'Add',
                          style: appThemeData.textTheme.labelLarge!.copyWith(
                            color: AppLightColor.fillButton,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: InkWell(
                        onTap: () {
                          CreateAccountController.openDialogEducation(
                            context,
                          );
                        },
                        child: Text(
                          "Education :",
                          style: appThemeData.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                //Education
                ),
                GetBuilder<CreateAccountController>(initState: (state) {
                  Get.lazyPut(() => CreateAccountController(),);
                },builder: (logic) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 220.w,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Text(
                            CreateAccountController.selectedEducation.name ??
                                'No selected Education',
                            maxLines: 2,
                            style: appThemeData.textTheme.bodySmall,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            CreateAccountController.openDialogEducation(
                              context,
                            );
                          },
                          child: Text(
                            'Add',
                            style: appThemeData.textTheme.labelLarge!.copyWith(
                              color: AppLightColor.fillButton,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                //Jobs
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        "Job :",
                        style: appThemeData.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<JobDropDownController>(builder: (logic) {
                      return SizedBox(
                        width: 220.w,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Text(
                            CreateAccountController.selectedJob.name ??'',
                            maxLines: 2,
                            style: appThemeData.textTheme.bodySmall,
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          CreateAccountController.openDialogJob(context);
                        },
                        child: Text(
                          'Add',
                          style: appThemeData.textTheme.labelLarge!.copyWith(
                            color: AppLightColor.fillButton,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
