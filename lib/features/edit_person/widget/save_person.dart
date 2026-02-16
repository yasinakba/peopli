import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/person_screen/controller/person_controller.dart';
import 'package:test_test_test/features/person_screen/person_screen.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/widgets/customButton.dart';
import '../../create_person/controller/create_person_controller.dart';
class EditSavePerson extends GetView<CreatePersonController> {
  final FaceEntity face;
  EditSavePerson({required this.face});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50,left: 50,top: 20,bottom: 10),
      child: GetBuilder<CreatePersonController>(builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomElevatedButton(onPressed: (){Get.back();}, textColor: AppLightColor.textBoldColor, color: AppLightColor.cancelButtonFill, title: "Cancel", height: 29.h, width: 75.w),
          CustomElevatedButton(onPressed: (){
            Get.to(()=>PersonScreen(),arguments: face );
            }, textColor: AppLightColor.withColor, color: AppLightColor.saveButton, title: "Save", height: 29.h, width: 75.w),
        ],
      ),)
    );
  }
}
