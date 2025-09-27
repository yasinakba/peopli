import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../create_account/controller/create_account_controller.dart';

class SearchBottomController extends GetxController{
  TextEditingController displayNameController = TextEditingController();
  TextEditingController knowAsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  ScrollController scrollController = ScrollController();
int selected=0;
//2
int selectedItem=0;

  @override
  void onInit() {
    super.onInit();
    searchFace();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        facePage++;
        searchMoreFace();
      }
    });
  }
  final dio = Dio();
  int facePage = 1;
  Future<void> searchFace() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }
      final response = await dio.post(
          'https://api.peopli.ir/Api/Faces',
          queryParameters: {
            'token':token,
            'page':1,
            'take':15,
            'filter': displayNameController.text,
            'hometownId':CreateAccountController.selectedCity.id,
            'educationId':CreateAccountController.selectedEducation.id,
            'jobId':CreateAccountController.selectedJob.id,
            'birthDate':dateTimeController.text,
          }
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  Future<void> searchMoreFace() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }
      final response = await dio.post(
          'https://api.peopli.ir/Api/Faces',
          queryParameters: {
            'token':token,
            'page':1,
            'take':15,
            'filter': displayNameController.text,
            'hometownId':CreateAccountController.selectedCity.id,
            'educationId':CreateAccountController.selectedEducation.id,
            'jobId':CreateAccountController.selectedJob.id,
            'birthDate':dateTimeController.text,
          }
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
      } else {
        debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
    }
  }
  DateTime? selectedDate;

  void pickDateTime(context) async {
    DateTime now = DateTime.now();
    DateTime initialDate = DateTime(now.year - 18); // default: 18 years ago
    DateTime firstDate = DateTime(1900); // earliest selectable year
    DateTime lastDate = now; // latest selectable date: today

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: "Select your birth date",
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateTimeController.text = picked.toString();
      update();
      print("Selected birth date: $picked");
    }
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
