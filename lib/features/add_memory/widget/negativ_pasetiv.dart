import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../controller/add_memory_controller.dart';
class NegativPositive extends GetView<AddMemoryController> {
  const NegativPositive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
      child: SizedBox(
        width: 320.w,
        height: 50.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //negativ
              Row(
                children: [
                  Radio(
                      value: 0,
                      groupValue: controller.selectedRadio,
                      activeColor: AppLightColor.negativeFill,
                      onChanged: (val){
                        controller.setSelectedRadio(val!);
                      }
                  ),
                  Text("Negativ  ",style: appThemeData.textTheme.bodyLarge,),
                ],
              ),
              SizedBox(
                width: 15.w,
              ),
              Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: controller.selectedRadio,
                      activeColor: AppLightColor.polygonColor,
                      onChanged: (val){
                        controller.setSelectedRadio(val!);
                      }
                  ),
                  Text("Neutral  ",style: appThemeData.textTheme.bodyLarge,),
                ],
              ),
              SizedBox(
                width: 15.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio(
                      value: 2,
                      groupValue: controller.selectedRadio,
                      activeColor: AppLightColor.fillPositive,
                      onChanged: (val){
                        controller.setSelectedRadio(val!);
                      }
                  ),
                  Text("Positive",style: appThemeData.textTheme.bodyLarge,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
