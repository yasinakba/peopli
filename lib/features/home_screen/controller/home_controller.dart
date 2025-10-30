import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:test_test_test/features/first_screen/first_screen.dart';

class HomeController extends GetxController{
  Widget body = FirstScreen();
  RxInt index = 0.obs;
  PageController pageController=PageController(initialPage: 0);


  void updateIndexNav(int index){
    pageController.jumpToPage(index);
    index=index;
    update();
  }

  final _box=GetStorage();
  final _key='isDarkMode';


  ThemeMode get theme=> loadTheme() ? ThemeMode.dark : ThemeMode.light;



  bool loadTheme() => _box.read(_key) ?? false;


  void saveTheme(bool isDarkMode)=> _box.write(_key,isDarkMode);
  void changeTheme(ThemeData theme)=> Get.changeTheme(theme);
  void changeThemeMode(ThemeMode themeMode)=> Get.changeThemeMode(themeMode);
}