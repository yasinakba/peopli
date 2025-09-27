
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/education_entity.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/job_entity.dart';
import 'package:test_test_test/features/feature_location/entity/city_entity.dart';
import 'package:test_test_test/features/feature_location/entity/country_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';
import '../../create_person/widget/location.dart';
import '../../feature_job_and_education/controller/education_cotnroller.dart';
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
  File? pickedFile;
  String education="";

  @override
  void onInit() {

  }
  final dio = Dio();
  Future<void> signUp() async {
    // ✅ Step 1: Input validation
    if (nameController.text.isEmpty ||
        familyController.text.isEmpty ||
        userNameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        pickedFile == null ||
        selectedDate == null ||
        selectedCity == null ||
        selectedEducation == null) {
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
      // ✅ Step 2: API request
      final response = await dio.post(
        "https://api.peopli.ir/Api/register",
        queryParameters: {
          "displayName": "${nameController.text} ${familyController.text}",
          "username": userNameController.text,
          "password": passwordController.text,
          "avatar": pickedFile!.path,
          "birthDate": selectedDate.toString(), // make sure API accepts String
          "cityId": selectedCity.id,
          "educationId": selectedEducation.id,
        },
      );

      print(response.data);

      SharedPreferences preferences = await SharedPreferences.getInstance();

      // ✅ Step 3: Success / Error handling
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        await preferences.setString('token', response.data['data']);
        Get.toNamed(NamedRoute.routeHomeScreen);
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: response.data['data'] ?? 'Registration failed',
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } on DioException catch (e) {
      print("POST error: ${e.response?.statusCode} - ${e.message}");
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Something went wrong: ${e.message}',
          duration: const Duration(seconds: 3),
        ),
      );
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

  uploadImage() async {
    final  picker = ImagePicker();
   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    pickedFile=File(pickedImage!.path);
    update();
  }


 static late EducationEntity selectedEducation;
 static openDialogEducation(context){
      showDialog(context: context, builder: (context)=>GetBuilder<EducationController>(id:'education',initState: (state) {
        Get.lazyPut(()=>EducationController());
        selectedEducation = Get.find<EducationController>().educationList[0];
      },builder: (controller) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            title: Text("Educations", style: appThemeData.textTheme.headlineSmall,),
            backgroundColor: AppLightColor.backgoundPost,

            actions: [Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.educationList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person_add, color: AppLightColor
                            .fillButton,),
                        subtitle: Text(
                          "Please select the desired degree", style: appThemeData
                            .textTheme.bodyMedium,),
                        onTap: () {
                          selectedEducation = controller.educationList[index];
                          controller.update(['education']);
                          Get.back();
                        },
                        title: Text(controller.educationList[index].name??'failed', style: appThemeData.textTheme
                            .headlineSmall),
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
                      )
                    ],
                  );
                },
              ),
            )
            ]
        );
      }));}


 static late CountryEntity selectedCountry;
 static late CityEntity selectedCity;
    //location
 static openDialogLocation(context){
    showDialog(context: context, builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        title: Text("Location",style: appThemeData.textTheme.headlineSmall,),
        backgroundColor: AppLightColor.backgoundPost,
        actions:[
          GetBuilder<LocationController>(
          id: 'country',
            initState: (state) {
              selectedCountry = Get.find<LocationController>().countryList[0];
            },
            builder: (controller) {
            return  Container(
              height: 100.h,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: DropdownSearch<CountryEntity>(
                    items: controller.countryList,
                    selectedItem: selectedCountry,
                    itemAsString: (CountryEntity? country) => country?.name ?? "",
                    compareFn: (CountryEntity? a, CountryEntity? b) => a?.id == b?.id, // 👈 lets DropdownSearch know equality
                    onChanged: (value) {
                      selectedCountry = value!;
                      Get.lazyPut(() => LocationController(),);
                     Get.find<LocationController>().getCity(selectedCountry.id); // load cities for selected country

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
                    dropdownDecoratorProps: DropDownDecoratorProps( // 👈 must be here, not inside searchFieldProps
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
            initState: (state) {
            },
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
                      },
                      selectedItem: selectedCity,
                      itemAsString: (CityEntity? city) => city!.name ??'',
                      compareFn: (CityEntity? a,CityEntity? b)=>a?.id == b?.id,
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
              child: CustomElevatedButton(onPressed: (){
                Get.back();
              }, textColor: AppLightColor.withColor, color: AppLightColor.textBlueColor, title: "Save", height: 40.h, width: 120.w))
        ]
    ));



  }








 static late JobEntity selectedJob;

 static openDialogJob(context){
    showDialog(context: context, builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        title: Text("Jobs",style: appThemeData.textTheme.headlineSmall,),
        backgroundColor: AppLightColor.backgoundPost,

        actions:[GetBuilder<JobDropDownController>(initState:(state) {
          Get.lazyPut(() => JobDropDownController(),);
         selectedJob = Get.find<JobDropDownController>().jobList[0];
        },builder: (controller) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            title: Text("Jobs", style: appThemeData.textTheme.headlineSmall,),
            backgroundColor: AppLightColor.backgoundPost,

            actions: [Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.jobList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person_add, color: AppLightColor
                            .fillButton,),
                        subtitle: Text(
                          "Please select the desired degree", style: appThemeData
                            .textTheme.bodyMedium,),
                        onTap: () {
                          selectedJob = controller.jobList[index];
                          Get.back();
                          controller.update();
                        },
                        title: Text(controller.jobList[index].name??'failed', style: appThemeData.textTheme
                            .headlineSmall),
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
                      )
                    ],
                  );
                },
              ),
            ),
            ],
          );
        })]
    ));



  }

  //openDialogLocation


  //openDialogPerson
  openDialogPerson(context){
    showDialog(context: context, builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Do you mean?",style: appThemeData.textTheme.headlineSmall,),
            Text("23 Result",style: appThemeData.textTheme.labelLarge,),
          ],
        ),
        backgroundColor: AppLightColor.backgoundPost,

        actions:[Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AppLightColor.strokePositive,width: 1),
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

                      //divider

                    ],
                  );
                },
              ),

          ),
        ),


        ],


    )

    );



  }
}


