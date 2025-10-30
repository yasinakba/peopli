import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_png.dart';
import '../controller/home_controller.dart';
import 'bottom_navbar_widget.dart';
class NavigationBarWidget extends GetView<HomeController> {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppLightColor.buttonNavbar,
      ),
      width: 374.w,
      height: 46.h,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavbarWidget(
                  assetsImage: AppAssetsPng.iconNavbarOne,
                  colorIcon: controller.currentIndex == 0
                      ? AppLightColor.rectangleBold
                      : AppLightColor.rectangle,
                      onTap: (){
                      controller.updateIndexNav(0);
                      },
              ),
              BottomNavbarWidget(
                  assetsImage: AppAssetsPng.iconNavbarTwo,
                  colorIcon: controller.currentIndex == 1
                      ? AppLightColor.rectangleBold
                      : AppLightColor.rectangle
                ,
                onTap: (){
                  controller.updateIndexNav(1);
                },
              ),
              BottomNavbarWidget(
                  assetsImage: AppAssetsPng.iconNavbarThree,
                  colorIcon: controller.currentIndex == 2
                      ? AppLightColor.rectangleBold
                      : AppLightColor.rectangle,
                onTap: (){
                  controller.updateIndexNav(2);
                },),
              BottomNavbarWidget(
                  assetsImage: AppAssetsPng.iconNavbarFour,
                  colorIcon: controller.currentIndex == 3
                      ? AppLightColor.rectangleBold
                      : AppLightColor.rectangle,
                onTap: (){
                  controller.updateIndexNav(3);
                },),
              BottomNavbarWidget(
                  assetsImage: AppAssetsPng.iconPerson,
                onTap: (){
                  controller.updateIndexNav(4);
                },),
            ],
          ),
        ),
      ),
    );
  }
}
