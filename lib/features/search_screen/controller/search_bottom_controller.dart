import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../create_account/controller/create_account_controller.dart';
import '../../feature_job_and_education/controller/job_controller.dart';
import '../../feature_job_and_education/entity/education_entity.dart';
import '../../feature_job_and_education/entity/job_entity.dart';
import '../../feature_job_and_education/view/education_drop_down_global.dart';
import '../../feature_location/controller/location_controller.dart';
import '../../feature_location/entity/city_entity.dart';
import '../../feature_location/entity/country_entity.dart';

class SearchBottomController extends GetxController {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController knowAsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int selected = 0;

  //2
  int selectedItem = 0;

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
          'token': token,
          'page': 1,
          'take': 15,
          'filter': displayNameController.text,
          'hometownId': selectedCity!.id,
          'educationId': selectedEducation!.id,
          'jobId': selectedJob!.id,
          'birthDate': dateTimeController.text,
        },
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
      } else {
        debugPrint(
          "❌ Error: ${response.statusCode} -> ${response.statusMessage}",
        );
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
          'token': token,
          'page': 1,
          'take': 15,
          'filter': displayNameController.text,
          'hometownId': selectedCity!.id,
          'educationId': selectedEducation!.id,
          'jobId': selectedJob!.id,
          'birthDate': dateTimeController.text,
        },
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
      } else {
        debugPrint(
          "❌ Error: ${response.statusCode} -> ${response.statusMessage}",
        );
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

  updateIndexButton(index) {
    selected = index;
    update();
  }

  //2
  updateIndexButtonItem(index) {
    selectedItem = index;
    update();
  }

  Color colorCustomButton(int index) {
    return index == selected
        ? AppLightColor.elipsFill
        : AppLightColor.withColor;
  }

  Color colorCustomButtonItem(int index) {
    return index == selectedItem
        ? AppLightColor.elipsFill
        : AppLightColor.withColor;
  }

  textColorCustomButton(int index) {
    return index == selected
        ? appThemeData.textTheme.labelSmall
        : appThemeData.textTheme.labelLarge;
  }

  //2
  textColorCustomButtonItem(int index) {
    return index == selectedItem
        ? appThemeData.textTheme.labelSmall
        : appThemeData.textTheme.labelLarge;
  }

  EducationEntity? selectedEducation;

  openDialogEducation(context) {
    showDialog(
      context: context,
      builder: (context) =>
          EducationDropDownGlobal(selectedEducation: selectedEducation),
    );
  }

  CountryEntity? selectedCountry;

  openDialogLocationCountry(context) {
    showDialog(
      context: context,
      builder: (context) => GetBuilder<LocationController>(
        id: 'country',
        initState: (state) {
          Get.lazyPut(() => LocationController());
          selectedCountry = Get.find<LocationController>().countryList[0];
        },
        builder: (controller) {
          return Container(
            height: 100.h,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: "search country",
                        helperStyle: appThemeData.textTheme.bodySmall,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  items: controller.countryName,
                  onChanged: print,
                  selectedItem: selectedCountry!.name ?? '',
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  CityEntity? selectedCity;

  openDialogLocationCity(context) {
    showDialog(
      context: context,
      builder: (context) => GetBuilder<LocationController>(
        id: 'country',
        initState: (state) {
          Get.lazyPut(() => LocationController());
          selectedCity = LocationController.cityList[0];
        },
        builder: (controller) {
          return Container(
            height: 100.h,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: "search country",
                        helperStyle: appThemeData.textTheme.bodySmall,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  items: controller.cityNames,
                  onChanged: print,
                  selectedItem: selectedCity!.name ?? '',
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  JobEntity? selectedJob;

  openDialogJobs(context) {
    showDialog(
      context: context,
      builder: (context) => GetBuilder<JobDropDownController>(
        builder: (controller) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            title: Text("Jobs", style: appThemeData.textTheme.headlineSmall),
            backgroundColor: AppLightColor.backgoundPost,

            actions: [
              Container(
                height: 300.0, // Change as per your requirement
                width: 300.0, // Change as per your requirement
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.jobList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.person_add,
                            color: AppLightColor.fillButton,
                          ),
                          subtitle: Text(
                            "Please select the desired degree",
                            style: appThemeData.textTheme.bodyMedium,
                          ),
                          onTap: () {
                            selectedJob = controller.jobList[index];
                            Get.back();
                            controller.update();
                          },
                          title: Text(
                            controller.jobList[index].name ?? 'failed',
                            style: appThemeData.textTheme.headlineSmall,
                          ),
                          selectedColor: AppLightColor.elipsFill,
                          focusColor: AppLightColor.strokePositive,
                        ),
                        //divider
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: AppLightColor.strokePositive,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
