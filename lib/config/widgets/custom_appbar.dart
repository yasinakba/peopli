import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../features/home_screen/controller/home_controller.dart';
import '../app_colors/app_colors_light.dart';
import '../app_theme/app_theme.dart';
import 'customButton.dart';

class CustomeAppBar extends GetView<HomeController>
    implements PreferredSizeWidget {
  const CustomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.white,
      leading: GetBuilder<HomeController>(
        builder: (a) => SizedBox(
            child: controller.index == 0
                ? SizedBox.shrink()
                : SizedBox.shrink()),
      ),
      title: Text("Peopli", style: appThemeData.textTheme.displayMedium),
      actions: [
        Row(
          children: [
            GetBuilder<HomeController>(
              builder: (controller) => IconButton(
                  onPressed: () {
                    if (Get.isDarkMode) {
                      controller.changeTheme(ThemeData.light());
                      controller.saveTheme(false);
                    } else {
                      controller.changeTheme(ThemeData.dark());
                      controller.saveTheme(true);
                    }
                  },
                  icon: Icon(
                    controller.loadTheme() == true
                        ? Icons.dark_mode
                        : Icons.dark_mode_outlined,
                    color: AppLightColor.strokeRectangleType,
                  )),
            ),
            GetBuilder<HomeController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15, right: 10),
                child: controller.index == 1
                    ? Text(
                        'search',
                        style: appThemeData.textTheme.headlineMedium,
                      )
                    : SizedBox(
                        child: CustomElevatedButton(
                            onPressed: () {},
                            textColor: AppLightColor.textBoldColor,
                            color: AppLightColor.mapButton,
                            title: 'map',
                            height: 22.h,
                            width: 75.w)
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
