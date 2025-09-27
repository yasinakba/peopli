import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/widgets/customButton.dart';
import '../../create_person/controller/create_person_controller.dart';
class EditSavePerson extends GetView<CreatePersonController> {
  const EditSavePerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50,left: 50,top: 20,bottom: 10),
      child: GetBuilder<CreatePersonController>(builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomElevatedButton(onPressed: (){Get.back();}, textColor: AppLightColor.textBoldColor, color: AppLightColor.cancelButtonFill, title: "Cancel", height: 29.h, width: 75.w),
          CustomElevatedButton(onPressed: (){Get.toNamed(NamedRoute.routePersonScreen);}, textColor: AppLightColor.withColor, color: AppLightColor.saveButton, title: "Save", height: 29.h, width: 75.w),
        ],
      ),)
    );
  }
}
