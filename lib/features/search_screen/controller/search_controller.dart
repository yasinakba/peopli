import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';

class SearchButtomController extends GetxController{

int selected=0;
//2
int selectedItem=0;

  @override
  void onInit() {

  }

  updateIndexButton(index){
    selected=index;
    update();
  }
  //2
  updateIndexButtonItem(index){
    selectedItem=index;
    update();
  }


Color colorCustomButton(int index){
    return index==selected?AppLightColor.elipsFill:AppLightColor.withColor;

}
//2
  Color colorCustomButtonItem(int index){
    return index==selectedItem?AppLightColor.elipsFill:AppLightColor.withColor;

  }



textColorCustomButton(int index){
    return index==selected?appThemeData.textTheme.labelSmall:appThemeData.textTheme.labelLarge;
}
//2
  textColorCustomButtonItem(int index){
    return index==selectedItem?appThemeData.textTheme.labelSmall:appThemeData.textTheme.labelLarge;
  }


}
