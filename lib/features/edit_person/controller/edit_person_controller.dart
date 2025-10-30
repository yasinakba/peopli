import 'dart:io';
import 'package:get/get.dart';
import '../../../config/app_theme/app_theme.dart';

class EditPersonController extends GetxController {
  int selectedRadio = 0;
  int selectedLanguage = 0;
  File? pickedFile;
  String education="";
  String jobs="";




  updateLAnguage(int index) {
    selectedLanguage = index;
    update();
  }

  setSelectedRadio(int val) {
    selectedRadio = val;
    update();
  }

  textStyleEn(int index) {
    return index == selectedLanguage
        ? appThemeData.textTheme.headlineSmall
        : appThemeData.textTheme.bodyLarge;
  }
}


