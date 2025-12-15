import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:test_test_test/features/search_screen/widget/bottom_search_screen.dart';
import 'package:test_test_test/features/search_screen/widget/search_information_location.dart';
import 'package:test_test_test/features/search_screen/widget/text_field_search.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/widgets/custom_radio_button.dart';
import 'controller/search_bottom_controller.dart';

class SearchScreen extends GetView<SearchBottomController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchBottomController>(
        builder: (controller) {
          return  SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //search
                  Center(
                    child: Container(
                      alignment: Alignment.topCenter,
                    padding:  EdgeInsets.symmetric(
                        horizontal: 10.w,
                      vertical: 10.h
                    ), margin: EdgeInsets.all(10.h),
                      width: 360.w,
                      // constraints: BoxConstraints(
                      //   // maxHeight: 500.h,
                      //   minHeight: 350.h,
                      // ),
                      decoration: BoxDecoration(
                        color: AppLightColor.withColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: AppLightColor.cancelButtonFill,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomRadioButton(
                                onPressed: () =>
                                    controller.updateIndexButton(0),
                                style: controller.textColorCustomButton(0),
                                color: controller.colorCustomButton(0),
                                title: 'Item',
                                height: 22.h,
                                width: 103.w,
                              ),
                              SizedBox(width: 60.h),
                              CustomRadioButton(
                                onPressed: () =>
                                    controller.updateIndexButton(1),
                                style: controller.textColorCustomButton(1),
                                color: controller.colorCustomButton(1),
                                title: 'Map',
                                height: 22.h,
                                width: 103.h,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          //row2
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomRadioButton(
                                onPressed: () =>
                                    controller.updateIndexButtonItem(0),
                                style: controller.textColorCustomButtonItem(0),
                                color: controller.colorCustomButtonItem(0),
                                title: 'Newest',
                                height: 22.h,
                                width: 84.w,
                              ),
                              CustomRadioButton(
                                onPressed: () =>
                                    controller.updateIndexButtonItem(1),
                                style: controller.textColorCustomButtonItem(1),
                                color: controller.colorCustomButtonItem(1),
                                title: 'Oldest',
                                height: 22.h,
                                width: 84.w,
                              ),
                              CustomRadioButton(
                                onPressed: () =>
                                    controller.updateIndexButtonItem(2),
                                style: controller.textColorCustomButtonItem(2),
                                color: controller.colorCustomButtonItem(2),
                                title: 'Popular',
                                height: 22.h,
                                width: 84.w,
                              ),
            
                            ],
                          ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(onPressed: () {
                                    controller.searchFace(1);
                                  }, icon: Icon(IconsaxPlusBold.search_normal_1)),
                                  TextFieldSearch(
                                    controller: controller.displayNameController,
                                    labelText: 'Name & Family',
                                  ),
                                ],
                              ),
            
                          SearchInformationLocation(),
                          //location
            
                        ],
                      ),
                    ),
                  ), //searchListTile
                 BottomSearchScreen(),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
