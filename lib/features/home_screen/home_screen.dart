import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../config/widgets/custom_appbar.dart';
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
      appBar: CustomeAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: controller.body,
      ),
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
              controller.body = HomeScreen();
              break;
            case 1:
              controller.body = SearchScreen();
              break;
            case 2:
              controller.body = CreatePersonScreen();
              break;
            case 3:
              controller.body = HeartScreen();
              break;
            case 4:
              controller.body = ProfileScreen();
              break;
          }
        },
      );
    }
    ));
  }
}

// GetBuilder<HomeController>(
// builder: (controller) {
// return Stack(
// children: [
// PageView(
// // index: controller.currentIndex,
// controller: controller.pageController,
// onPageChanged: controller.updateIndexNav,
// children: [
// FirstScreen(),
// SearchScreen(),
// CreatePersonScreen(),
// HeartScreen(),
// ProfileScreen(),
// ],
// ),
// Align(
// alignment: Alignment.bottomCenter,
// child: NavigationBarWidget(),
// ),
// ],
// );
// },
// )
