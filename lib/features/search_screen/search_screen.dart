import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/features/search_screen/widget/bottom_search_screen.dart';
import 'package:test_test_test/features/search_screen/widget/search_information_location.dart';
import 'package:test_test_test/features/search_screen/widget/text_field_search.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/custom_radio_button.dart';
import 'controller/search_bottom_controller.dart';

class SearchScreen extends GetView<SearchBottomController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchBottomController>(
        builder: (controller) {
          return  Column(
            children: [
              //search
              Container(
              padding:  EdgeInsets.symmetric(
                  horizontal: 10.w,
                vertical: 3.h
              ), margin: EdgeInsets.only(top: 2.h),
                width: 375.w,
                constraints: BoxConstraints(
                  // maxHeight: 500.h,
                  minHeight: 350.h,
                ),
                decoration: BoxDecoration(
                  color: AppLightColor.withColor,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: AppLightColor.cancelButtonFill,
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
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

                        //birth
                        Container(
                          width: 285.w,
                          height: 32.h,
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsetsDirectional.only(
                            start: 10.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black),
                          ),
                          child:  GetBuilder<DateController>(
                            initState: (state) => Get.lazyPut(() => DateController(),),
                            builder: (controller) {
                              // Safely handle null controller or date
                              final safeDate = controller.selectedDate;
                              final formattedDate = DateFormat('yyyy/MM/dd – HH:mm').format(safeDate);
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: appThemeData.textTheme.bodySmall ??
                                        const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      controller.pickDateTime(context);
                                    },
                                    icon: const Icon(
                                      Icons.calendar_today,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                    SearchInformationLocation(),
                    //location

                  ],
                ),
              ), //searchListTile
             BottomSearchScreen(),
            ],
          );
        }
      ),
    );
  }
}
