import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../controller/create_person_controller.dart';

class GenderPerson extends GetView<CreatePersonController> {
  const GenderPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Gender : ",style: appThemeData.textTheme.bodyLarge,),
          SizedBox(
            width: 170.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Radio(
                        value: 1,
                        groupValue: controller.selectedRadio,
                        activeColor: AppLightColor.rectangleBold,
                        onChanged: (val){
                          controller.setSelectedRadio(val!);
                        }
                    ),
                    Text("Male",style: appThemeData.textTheme.bodyLarge,)
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 2,
                        groupValue: controller.selectedRadio,
                        activeColor:AppLightColor.rectangleBold,
                        onChanged: (val){
                          controller.setSelectedRadio(val!);
                        }
                    ),
                    Text("Female",style: appThemeData.textTheme.bodyLarge,)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
