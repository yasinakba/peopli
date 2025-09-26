
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/education_entity.dart';
import 'package:test_test_test/features/feature_job_and_education/entity/job_entity.dart';
import 'package:test_test_test/features/feature_job_and_education/view/education_drop_down_global.dart';
import 'package:test_test_test/features/feature_job_and_education/view/job_drop_down_global.dart';
import 'package:test_test_test/features/feature_location/entity/city_entity.dart';
import 'package:test_test_test/features/feature_location/entity/country_entity.dart';
import 'package:test_test_test/features/feature_location/view/location_global_widget.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';
import '../../feature_job_and_education/controller/job_controller.dart';
import '../../feature_location/controller/location_controller.dart';
import '../widget/create_cancel_person.dart';
import '../widget/listTile_create.dart';
import '../widget/location.dart';

class CreatePersonController extends GetxController {
   TextEditingController nameController = TextEditingController();
   TextEditingController familyNameController = TextEditingController();
   TextEditingController knowAsController = TextEditingController();
   TextEditingController locationController = TextEditingController();
   int selectedRadio = 0;
  int selectedLanguage = 0;
  File? pickedFile;
  String education="";
  String jobs="";
  final dio = Dio();
  @override
  void onInit() {

  }
   /// Simple POST request with error handling



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
// Pick an image.
   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    pickedFile=File(pickedImage!.path);
    update();
  }


 EducationEntity? selectedEducation;
  openDialogEducation(context){
      showDialog(context: context, builder: (context)=>EducationDropDownGlobal(selectedEducation: selectedEducation,));

    }

   late CountryEntity selectedCountry;
    //location
  openDialogLocationCountry(context){
    showDialog(context: context, builder: (context)=>GetBuilder<LocationController>(
      id: 'country',
      initState: (state) {
        Get.lazyPut(() => LocationController(),);
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
                selectedItem: selectedCountry.name ??'',
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
    ));



  }
   late CityEntity selectedCity;

   openDialogLocationCity(context){
    showDialog(context: context, builder: (context)=>GetBuilder<LocationController>(
      id: 'country',
      initState: (state) {
        Get.lazyPut(() => LocationController(),);
       selectedCity= LocationController.cityList[0];
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
                selectedItem: selectedCity.name ??'',
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
    ));
  }
  

  JobEntity? selectedJob;
  openDialogJobs(context){
    showDialog(context: context, builder: (context)=>GetBuilder<JobDropDownController>(builder: (controller) {
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
    }),);



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
                reverse:true,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ListTileCreate();
                },
              ),

          ),
        ),
          CreateCancelPerson()

        ],


    )

    );



  }
}


