import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide FormData;
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/education_entity.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/job_entity.dart';
import 'package:test_test_test/features/feature_location/entity/city_entity.dart';
import 'package:test_test_test/features/feature_location/entity/country_entity.dart';


import 'package:test_test_test/features/feature_job_and_education/controller/education_cotnroller.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';


import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';

import '../../../config/widgets/customButton.dart';

import '../../feature_job_and_education/controller/job_controller.dart';
import '../../feature_location/controller/location_controller.dart';

class CreateAccountController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  int selectedRadio = 0;
  int selectedLanguage = 0;


  final dio = Dio();
  bool loading = false;
  Future<void> signUp() async {
    loading = true;
    update();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // ✅ Step 1: Input validation
    if (nameController.text.isEmpty ||
        familyController.text.isEmpty ||
        userNameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        Get.find<UploadController>().selectedImage.value == '' ||
        Get.find<DateController>().selectedDate.timeZoneName == '' ||
        selectedCity.id == null ||
        selectedEducation.id == null) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Validation Error',
          message: 'Please fill all required fields!',
          duration: Duration(seconds: 3),
        ),
      );
      return; // Stop execution if validation fails
    }

    try {
      FormData formData = FormData.fromMap({
        'displayName': '${nameController.text} ${familyController.text}',
        'username': userNameController.text,
        'password': passwordController.text,
        'birthDate': Get.find<DateController>().selectedDate.toString(),
        'cityId': selectedCity.id,
        'educationId': selectedEducation.id,
        'avatar': Get.find<UploadController>().selectedImage.value,
      });
    // ✅ Step 4: Make POST request with body, not queryParameters
    final response = await dio.postUri(
      Uri.parse(
        '$baseURL/Api/register',
      ),
      data: formData,
      options: Options(
        contentType: Headers.formUrlEncodedContentType, // crucial for .NET backend
      ),
    );
      print(response.data);
      if (response.statusCode == 200) {
      await preferences.setString('token', response.data['data']);
      loading = false;
      update();
      Get.back();
    } else {
        loading = false;
        update();
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: response.data['data'] ?? 'Registration failed',
          duration: const Duration(seconds: 3),
        ),
      );

    }
    } on DioException catch (e) {
      loading = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Something went wrong: ${e.message}',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

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


  static  EducationEntity selectedEducation = EducationEntity();

  static openDialogEducation(context) {
    showDialog(
      context: context,
      builder: (context) => GetBuilder<EducationController>(
        id: 'education',
        initState: (state) {
          Get.lazyPut(() => EducationController());
          selectedEducation = Get.find<EducationController>().educationList[0];
        },
        builder: (controller) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            title: Text(
              "Educations",
              style: appThemeData.textTheme.headlineSmall,
            ),
            backgroundColor: AppLightColor.backgoundPost,

            actions: [
              Container(
                height: 300.0, // Change as per your requirement
                width: 300.0, // Change as per your requirement
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.educationList.length,
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
                            selectedEducation = controller.educationList[index];
                            controller.update(['education']);
                            Get.lazyPut(() => CreateAccountController(),);
                            Get.find<CreateAccountController>().update();
                            Get.back();
                          },
                          title: Text(
                            controller.educationList[index].name ?? 'failed',
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

  static  CountryEntity selectedCountry = CountryEntity();
  static  CityEntity selectedCity = CityEntity();

  //location
  static openDialogLocation(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Text("Location", style: appThemeData.textTheme.headlineSmall),
        backgroundColor: AppLightColor.backgoundPost,
        actions: [
          GetBuilder<LocationController>(
            id: 'country',
            initState: (state) {
              selectedCountry = Get.find<LocationController>().countryList[0];
            },
            builder: (controller) {
              return Container(
                height: 100.h,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownSearch<CountryEntity>(
                      items: controller.countryList,
                      selectedItem: selectedCountry,
                      itemAsString: (CountryEntity? country) =>
                          country?.name ?? "",
                      compareFn: (CountryEntity? a, CountryEntity? b) =>
                          a?.id == b?.id,
                      onChanged: (value) {
                        selectedCountry = value!;
                        Get.lazyPut(() => LocationController());
                        Get.find<LocationController>().getCity(
                          selectedCountry.id,
                        );
                        controller.update(['createPersonLocation']);
                        controller.update();
                        Get.lazyPut(() => CreateAccountController());
                        Get.find<CreateAccountController>().update();
                      },
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "search country",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        // 👈 must be here, not inside searchFieldProps
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
          GetBuilder<LocationController>(
            id: 'city',
            builder: (controller) {
              return Container(
                height: 100.h,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownSearch<CityEntity>(
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
                      items: LocationController.cityList,
                      onChanged: (value) {
                        print;
                        selectedCity = value!;
                        controller.update();
                        Get.lazyPut(() => CreateAccountController());
                        Get.find<CreateAccountController>().update();
                      },
                      selectedItem: selectedCity,
                      itemAsString: (CityEntity? city) => city!.name ?? '',
                      compareFn: (CityEntity? a, CityEntity? b) =>
                          a?.id == b?.id,
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
          Align(
            alignment: Alignment.center,
            child: CustomElevatedButton(
              onPressed: () {
                Get.back();
              },
              textColor: AppLightColor.withColor,
              color: AppLightColor.textBlueColor,
              title: "Save",
              height: 40.h,
              width: 120.w,
            ),
          ),
        ],
      ),
    );
  }

  static  JobEntity selectedJob = JobEntity();

  static openDialogJob(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Text("Jobs", style: appThemeData.textTheme.headlineSmall),
        backgroundColor: AppLightColor.backgoundPost,

        actions: [
          GetBuilder<JobDropDownController>(
            initState: (state) {
              Get.lazyPut(() => JobDropDownController());
              selectedJob = Get.find<JobDropDownController>().jobList[0];
            },
            builder: (controller) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                title: Text(
                  "Jobs",
                  style: appThemeData.textTheme.headlineSmall,
                ),
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
        ],
      ),
    );
  }

  //openDialogLocation

  //openDialogPerson
  openDialogPerson(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Do you mean?", style: appThemeData.textTheme.headlineSmall),
            Text("23 Result", style: appThemeData.textTheme.labelLarge),
          ],
        ),
        backgroundColor: AppLightColor.backgoundPost,

        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: AppLightColor.strokePositive,
                  width: 1,
                ),
                color: AppLightColor.withColor,
              ),
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
