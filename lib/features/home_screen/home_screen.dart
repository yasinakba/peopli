import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:test_test_test/config/widgets/custom_appbar.dart';
import 'package:test_test_test/features/first_screen/first_screen.dart';

import '../create_person/create_person.dart';
import '../heart/heart.dart';
import '../profile_screen/profile_screen.dart';
import '../search_screen/search_screen.dart';
import 'controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: GetBuilder<HomeController>(builder: (controller) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) async {
              Get.defaultDialog(
              title: 'Pay attention',
              titleStyle: TextStyle(fontSize: 18, color: Colors.black),
              middleText: 'Are you sure you want to exit the app?',
              middleTextStyle: TextStyle(fontSize: 16, color: Colors.grey.shade900),
              backgroundColor: Colors.blueGrey[100],
              radius: 15,
              textCancel: 'Cancel',
              cancelTextColor: Colors.black,
              onCancel: () {},
              textConfirm: 'Confirm',
              confirmTextColor: Colors.white,
              onConfirm: () {
              SystemNavigator.pop();
              },
              buttonColor: Colors.green,
              barrierDismissible: true,
              // for blur with click on everywhere
              actions: [
              // Icon(Icons.tab)
              ],
              );
            },
            child: controller.body,
          );
        }),
        bottomNavigationBar: Obx(() {
          return AnimatedBottomNavigationBar(
            inactiveColor: Colors.black54,
            activeColor: Colors.black,
            icons: [
              IconsaxPlusBold.home_2,
              IconsaxPlusBold.search_normal_1,
              IconsaxPlusBold.add_square,
              IconsaxPlusBold.heart,
              IconsaxPlusBold.profile,
            ],
            activeIndex: controller.index.value,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.smoothEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) {
              controller.index.value = index;
              switch (index) {
                case 0:
                  controller.body = FirstScreen();
                  controller.update();
                  break;
                case 1:
                  controller.body = SearchScreen();
                  controller.update();
                  break;
                case 2:
                  controller.body = CreatePersonScreen();
                  controller.update();
                  break;
                case 3:
                  controller.body = HeartScreen();
                  controller.update();
                  break;
                case 4:
                  controller.body = ProfileScreen();
                  controller.update();
                  break;
              }
            },
          );
        }
        ));
  }
}

