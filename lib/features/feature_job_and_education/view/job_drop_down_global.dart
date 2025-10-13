import 'package:flutter/material.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/job_controller.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/job_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import 'package:get/get.dart';


class JobDropDownGlobal extends StatelessWidget {
  final JobDropDownController jobDropdownController = Get.put(
      JobDropDownController());
  JobEntity selectedJob;
  JobDropDownGlobal({required this.selectedJob});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDropDownController>(builder: (controller) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Text("Jobs", style: appThemeData.textTheme.headlineSmall,),
          backgroundColor: AppLightColor.backgoundPost,

          actions: [Container(
            height: 300.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.jobList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_add, color: AppLightColor
                          .fillButton,),
                      subtitle: Text(
                        "Please select the desired degree", style: appThemeData
                          .textTheme.bodyMedium,),
                      onTap: () {
                        selectedJob = controller.jobList[index];
                       controller.update();
                        Get.back();
                      },
                      title: Text(controller.jobList[index].name??'failed', style: appThemeData.textTheme
                          .headlineSmall),
                      selectedColor: AppLightColor.elipsFill,
                      focusColor: AppLightColor.strokePositive,


                    ),
                    //divider
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: AppLightColor.strokePositive,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          ],
      );
    });
  }
}
