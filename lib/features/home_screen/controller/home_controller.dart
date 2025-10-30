import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{
  int currentIndex=0;
  PageController pageController=PageController(initialPage: 0);
  @override
  void onInit() {
    super.onInit();
  }


  void updateIndexNav(int index){
    pageController.jumpToPage(index);
    currentIndex=index;
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