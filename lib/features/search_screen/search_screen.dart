import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:test_test_test/features/search_screen/widget/search_list_tile.dart';
import 'package:test_test_test/features/search_screen/widget/text_field_search.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/custom_radio_button.dart';
import 'controller/search_bottom_controller.dart';

class SearchScreen extends GetView<SearchBottomController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchBottomController>(
        builder: (controller) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  //divider
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: AppLightColor.cancelButtonFill,
                  ),
                  //search
                  Container(
                    width: 375.w,
                    constraints: BoxConstraints(
                      // maxHeight: 500.h,
                      minHeight: 370.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppLightColor.withColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            right: 30,
                            left: 30,
                          ),
                          child: Row(
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
                              SizedBox(width: 60.w),
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
                        ),
                        //row2
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            right: 30,
                            left: 30,
                          ),
                          child: Row(
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
                        ),

                        //textField
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            right: 8,
                            left: 8,
                            bottom: 8,
                          ),
                          child: Column(
                            children: [
                              //name & family
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: InkWell(
                                      onTap: () {
                                        controller.searchFace();
                                      },
                                      child: Image.asset(
                                        AppAssetsPng.iconNavbarTwo,
                                        color: AppLightColor.textBoldColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 33),
                                    child: TextFieldSearch(
                                      controller: controller.displayNameController,
                                      labelText: 'Name & Family',
                                    ),
                                  ),
                                ],
                              ),

                              //birth
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 10),
                                child: Container(
                                  width: 285.w,
                                  height: 32.h,
                                  padding: EdgeInsetsDirectional.only(
                                    start: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.selectedDate != null
                                            ? DateFormat(
                                                'yyyy/MM/dd – HH:mm',
                                              ).format(controller.selectedDate!)
                                            : "No date selected",
                                        style: appThemeData.textTheme.bodySmall,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.pickDateTime(context);
                                        },
                                        icon: Icon(
                                          Icons.calendar_today,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //location
                        Container(
                          margin: EdgeInsetsDirectional.symmetric(
                            horizontal: 23.w,
                            vertical: 5.h,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                controller.searchWithLocation = true;
                                                controller
                                                    .openDialogLocation(
                                                      context,
                                                );
                                                controller.update();
                                              },
                                              child:controller.searchWithLocation? IconButton(onPressed: () {
                                                controller.searchWithLocation = false;
                                                controller.update();
                                              }, icon: Icon(IconsaxPlusBold.tag_cross,color: Colors.deepPurpleAccent.shade200,)):Text(
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
                                      Text(
                                        textAlign: TextAlign.start,
                                        "${controller.selectedCountry.id != null&& controller.searchWithLocation?controller.selectedCountry.name:''} ${controller.selectedCity.id!=null && controller.searchWithLocation?controller.selectedCity.name:''}",
                                        style: appThemeData
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              color: AppLightColor.fillButton,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 10,
                                  ),
                                  child: Text(
                                    "Education :",
                                    style: appThemeData.textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 220.w,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 5,
                                      ),
                                      child: Text(
                                       controller.searchWithEducation? controller.selectedEducation.name??'':'',
                                        maxLines: 2,
                                        style: appThemeData.textTheme.bodySmall,
                                      ),
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
                                      child:controller.searchWithEducation? IconButton(onPressed: () {
                                        controller.searchWithEducation = false;
                                        controller.update();
                                      }, icon: Icon(IconsaxPlusBold.tag_cross,color: Colors.deepPurpleAccent.shade200,)):Text(
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
                              SizedBox(height: 5.h),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 10,
                                  ),
                                  child: Text(
                                    "Job :",
                                    style: appThemeData.textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 220.w,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 5,
                                      ),
                                      child: Text(
                                        "${controller.selectedJob.id !=null && controller.searchWithJob?controller.selectedJob.name:''}",
                                        maxLines: 2,
                                        style: appThemeData.textTheme.bodySmall,
                                      ),
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
                                      child:controller.searchWithJob? IconButton(onPressed: () {
                                        controller.searchWithJob = false;
                                        controller.update();
                                      }, icon: Icon(IconsaxPlusBold.tag_cross,color: Colors.deepPurpleAccent.shade200,)):Text(
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
                        ),
                      ],
                    ),
                  ), //searchListTile
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                child: SearchListTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
