import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';
import '../../create_account/controller/create_account_controller.dart';
import '../../feature_job_and_education/controller/education_cotnroller.dart';
import '../../feature_job_and_education/controller/job_controller.dart';
import '../../feature_job_and_education/entity/education_entity.dart';
import '../../feature_job_and_education/entity/job_entity.dart';
import '../../feature_location/controller/location_controller.dart';
import '../../feature_location/entity/city_entity.dart';
import '../../feature_location/entity/country_entity.dart';

class SearchBottomController extends GetxController {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController knowAsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  late final pagingFaceController = PagingController<int,dynamic>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => searchFace(pageKey),
  );
  int selected = 0;

  //2
  int selectedItem = 0;

  @override
  void onInit() {
    super.onInit();
  }

  final dio = Dio();
  int facePage = 1;
  bool searchWithLocation = false;
  bool searchWithEducation = false;
  bool searchWithJob = false;
  bool loadingSearch = false;
  List<FaceEntity> faceList = [];
  Future<List<FaceEntity>> searchFace(pageKey) async {
    loadingSearch = true;
    update();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');

      if (token == null) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return faceList;
      }
      if (selectedCity.id == null || selectedEducation.id == null || selectedJob.id == null) {
        Get.snackbar("Error","⚠️ One or more required fields are null");
        return faceList;
      }

      final requestData = {
        'token': token,
        'page': 1,
        'take': 15,
        'filter': displayNameController.text,
        'hometownId':searchWithLocation? selectedCity.id:null,
        'educationId':searchWithEducation? selectedEducation.id:null,
        'jobId':searchWithJob?selectedJob.id:null,
        'birthDate': dateTimeController.text.isNotEmpty
            ? dateTimeController.text
            : '', // ensure API gets a valid string
      };
      final response = await dio.get(
        '$baseURL/Api/Faces',
        queryParameters: requestData,
      );
      if (response.statusCode == 200) {
        faceList.clear();
        List<dynamic> data = response.data['data']['faces'];
        faceList.addAll(data.map((i)=> FaceEntity.fromJson(i)));
        loadingSearch = false;
        update();
        return faceList;
      } else {
        Get.snackbar("Error","❌ Error: ${response.statusCode} -> ${response.statusMessage}",);
        loadingSearch = false;
        update();
        return faceList;
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while fetching memories: $e");
      debugPrint(stacktrace.toString());
      loadingSearch = false;
      update();
      return faceList;
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

  EducationEntity selectedEducation = EducationEntity(
    id: 9,
    name: "Worker3333",
    icon: "1",
    createdAt: "2025-03-20T15:34:53",
  );

  openDialogEducation(context) {
    showDialog(
      context: context,
      builder: (context) => GetBuilder<EducationController>(
        id: 'education',
        initState: (state) {
          Get.lazyPut(() => EducationController());
          if (Get.find<EducationController>().educationList.isNotEmpty) {
            selectedEducation =
                Get.find<EducationController>().educationList[0];
          }
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
                            Get.lazyPut(() => CreateAccountController());
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

  CountryEntity selectedCountry = CountryEntity(
    id: 208,
    name: "iran",
    citiesCount: 31,
    createdAt: "2025-02-28T21:10:28",
  );
  CityEntity selectedCity = CityEntity(
    id: 54,
    name: "yazd",
    country: "iran",
    createdAt: "2025-03-02T11:43:52",
  );

  //location
  openDialogLocation(context) {
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
                      // 👈 lets DropdownSearch know equality
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

  JobEntity selectedJob = JobEntity(
    id: 24,
    name: "۲۲۲۲۲",
    icon: "icon.png",
    createdAt: "2025-03-20T15:35:53",
  );

  openDialogJob(context) {
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
}
