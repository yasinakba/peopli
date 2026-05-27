import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:test_test_test/config/app_colors/app_colors_light.dart';
import 'package:test_test_test/config/app_string/app_key_string_ternationalization.dart';
import 'package:test_test_test/config/app_theme/app_theme.dart';
import 'package:test_test_test/features/search_screen/controller/search_bottom_controller.dart';
import 'package:get/get.dart';

import '../../create_account/controller/create_account_controller.dart';


class SearchInformationLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAccountController>(
        initState: (state) {
          Get.lazyPut(() => CreateAccountController(),);
        },
        builder: (controller) {
      return Container(
        margin: EdgeInsetsDirectional.symmetric(
          horizontal: 23.w,
          vertical: 5.h,
        ),
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 5,
          left: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Home Location :",
                  style: appThemeData
                      .textTheme
                      .bodyLarge,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.find<SearchBottomController>().searchWithLocation =
                      true;
                      CreateAccountController.openDialogLocation(
                        context,
                      );
                      controller.update();
                    },
                    child:  Get.find<SearchBottomController>()
                        .searchWithLocation
                        ? IconButton(onPressed: () {
                      Get.find<SearchBottomController>().searchWithLocation =
                      false;
                      controller.update();
                    },
                        icon: Icon(
                          IconsaxPlusBold.tag_cross,
                          color: Colors
                              .deepPurpleAccent
                              .shade200,))
                        : Text(
                      AppKeyLocalization.label6,
                      style: appThemeData
                          .textTheme
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
            Get.find<SearchBottomController>().searchWithLocation ? Text(
              textAlign: TextAlign.start,
              "${CreateAccountController.selectedCountry.name} ${ CreateAccountController.selectedCity
                  .name}",
              style: appThemeData
                  .textTheme
                  .labelLarge!
                  .copyWith(
                color: AppLightColor.fillButton,),
            ) : Text(''),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              padding: const EdgeInsets.only(
                top: 5,
                left: 10,
              ),
              width: double.infinity,
              child: Text(
                "${AppKeyLocalization.label8} :",
                style: appThemeData.textTheme.bodyLarge,
              ),
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 5,
                  ),
                  width: 220.w,
                  child: Text(
                    Get.find<SearchBottomController>().searchWithEducation
                        ? CreateAccountController.selectedEducation
                        .name ?? '' : '',
                    maxLines: 2,
                    style: appThemeData.textTheme.bodySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.find<SearchBottomController>().searchWithEducation = true;
                      CreateAccountController.openDialogEducation(context);
                      controller.update();
                    },
                    child: Get.find<SearchBottomController>().searchWithEducation
                        ? IconButton(onPressed: () {
                      Get.find<SearchBottomController>().searchWithEducation = false;
                      controller.update();
                    },
                        icon: Icon(IconsaxPlusBold.tag_cross,
                          color: Colors.deepPurpleAccent
                              .shade200,))
                        : Text(
                      AppKeyLocalization.label6,
                      style: appThemeData
                          .textTheme
                          .labelLarge!
                          .copyWith(
                        color: AppLightColor.fillButton,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 10,
              ),
              margin: EdgeInsets.only(top: 5.h),
              width: double.infinity,
              child: Text(
                "${AppKeyLocalization.label9} :",
                style: appThemeData.textTheme.bodyLarge,
              ),
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 5,
                  ),
                  width: 220.w,
                  child: Text(
                    "${Get.find<SearchBottomController>().searchWithJob
                        ? CreateAccountController.selectedJob.name
                        : ''}",
                    maxLines: 2,
                    style: appThemeData.textTheme.bodySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.find<SearchBottomController>().searchWithJob = true;
                      CreateAccountController.openDialogJob(context);
                      controller.update();
                    },
                    child: Get.find<SearchBottomController>().searchWithJob
                        ? IconButton(onPressed: () {
                      Get.find<SearchBottomController>().searchWithJob = false;
                      controller.update();
                    },
                        icon: Icon(IconsaxPlusBold.tag_cross,
                          color: Colors.deepPurpleAccent
                              .shade200,))
                        : Text(
                      AppKeyLocalization.label6,
                      style: appThemeData
                          .textTheme
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
      );
    });
  }
}
