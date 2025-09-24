import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../controller/create_perxon_controller.dart';

class InformationPerson extends GetView<CreatePersonController> {
  const InformationPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePersonController>(
      builder: (controller) => Container(
        width: 300.w,
        height: 220.h,
        decoration: BoxDecoration(
            color: AppLightColor.backgoundPost,
            borderRadius: BorderRadius.all(Radius.circular(25))),
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
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 220.w,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        "(2005-now) Avenue 13, Bond Pavilion, Mercury St., Paris, France",
                        maxLines: 2,
                        style: appThemeData.textTheme.bodySmall,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: (){controller.openDialogLocationCountry(context);},
                    child: Text(
                      'Add',
                      style: appThemeData.textTheme.labelLarge!
                          .copyWith(color: AppLightColor.fillButton),
                    ),
                  ),
                )
              ],
            ),

            //Education
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: InkWell(
                      onTap: (){controller.openDialogEducation(context);},
                      child: Text(
                        "Education :",
                        style: appThemeData.textTheme.bodyLarge,
                      ),
                    ),
                  )),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 220.w,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        controller.education,
                        maxLines: 2,
                        style: appThemeData.textTheme.bodySmall,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                      onTap: (){controller.openDialogEducation(context);},
                      child: Text(
                        'Add',
                        style: appThemeData.textTheme.labelLarge!
                            .copyWith(color: AppLightColor.fillButton),
                      )),
                )
              ],
            ),

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
                  )),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 220.w,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        controller.jobs,
                        maxLines: 2,
                        style: appThemeData.textTheme.bodySmall,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: (){
                      controller.openDialogJobs(context);
                    },
                    child: Text(
                      'Add',
                      style: appThemeData.textTheme.labelLarge!
                          .copyWith(color: AppLightColor.fillButton),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
