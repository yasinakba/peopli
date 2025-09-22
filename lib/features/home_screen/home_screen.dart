import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_test_test/features/home_screen/widget/navigation_bar_widget.dart';


import '../../config/widgets/custom_appbar.dart';
import '../create_person/creat_person.dart';
import '../first_screen/first_screen.dart';
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
        body: GetBuilder<HomeController>(
          builder: (c) => Stack(
            children: [
              PageView(
                  // index: controller.currentIndex,
                controller: controller.pageController,
                onPageChanged: controller.updateIndexNav,
                children: [
                  FirstScreen(),
                  SearchScreen(),
                  CreatePersonScreen(),
                  HeartScreen(),
                 ProfileScreen()
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: NavigationBarWidget()
              ),
            ],
          ),
        ));
  }
}
