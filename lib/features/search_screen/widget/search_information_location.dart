import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:test_test_test/config/app_colors/app_colors_light.dart';
import 'package:test_test_test/config/app_theme/app_theme.dart';
import 'package:test_test_test/features/search_screen/controller/search_bottom_controller.dart';
import 'package:get/get.dart';


class SearchInformationLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBottomController>(builder: (controller) {
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
                      controller.searchWithLocation =
                      true;
                      controller.openDialogLocation(
                        context,
                      );
                      controller.update();
                    },
                    child: controller
                        .searchWithLocation
                        ? IconButton(onPressed: () {
                      controller.searchWithLocation =
                      false;
                      controller.update();
                    },
                        icon: Icon(
                          IconsaxPlusBold.tag_cross,
                          color: Colors
                              .deepPurpleAccent
                              .shade200,))
                        : Text(
                      'Add',
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
            controller.searchWithLocation ? Text(
              textAlign: TextAlign.start,
              "${controller.selectedCountry.name} ${ controller.selectedCity
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
                "Education :",
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
                    controller.searchWithEducation
                        ? controller.selectedEducation
                        .name ?? '' : '',
                    maxLines: 2,
                    style: appThemeData.textTheme.bodySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      controller.searchWithEducation = true;
                      controller.openDialogEducation(context);
                      controller.update();
                    },
                    child: controller.searchWithEducation
                        ? IconButton(onPressed: () {
                      controller.searchWithEducation = false;
                      controller.update();
                    },
                        icon: Icon(IconsaxPlusBold.tag_cross,
                          color: Colors.deepPurpleAccent
                              .shade200,))
                        : Text(
                      'Add',
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
                "Job :",
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
                    "${controller.searchWithJob
                        ? controller.selectedJob.name
                        : ''}",
                    maxLines: 2,
                    style: appThemeData.textTheme.bodySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      controller.searchWithJob = true;
                      controller.openDialogJob(context);
                      controller.update();
                    },
                    child: controller.searchWithJob
                        ? IconButton(onPressed: () {
                      controller.searchWithJob = false;
                      controller.update();
                    },
                        icon: Icon(IconsaxPlusBold.tag_cross,
                          color: Colors.deepPurpleAccent
                              .shade200,))
                        : Text(
                      'Add',
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
