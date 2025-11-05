import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';
import '../../feature_job_and_education/controller/education_cotnroller.dart';
import '../../feature_job_and_education/controller/job_controller.dart';
import '../../feature_job_and_education/entity/education_entity.dart';
import '../../feature_job_and_education/entity/job_entity.dart';
import '../../feature_location/controller/location_controller.dart';
import '../../feature_location/entity/city_entity.dart';
import '../../feature_location/entity/country_entity.dart';
import '../../search_screen/controller/search_bottom_controller.dart';
import '../widget/create_cancel_person.dart';
import '../widget/listTile_create.dart';
import 'package:flutter/foundation.dart';

class CreatePersonController extends GetxController {
  TextEditingController displayNameController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   TextEditingController familyNameController = TextEditingController();
   TextEditingController knowAsController = TextEditingController();
   TextEditingController locationController = TextEditingController();
   TextEditingController dateTimeController = TextEditingController();
   bool searchWithLocation = false;
   bool searchWithEducation = false;
   bool searchWithJob = false;
   List<FaceEntity> faceList = [];
   late final pagingFaceController = PagingController<int,dynamic>(
     getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
     fetchPage: (pageKey) => searchFace(pageKey),
   );
   int selectedRadio = 0;
   int selectedLanguage = 0;
   XFile? pickedFile;
   String gender = '';
   @override void onInit() {
    super.onInit();
    Get.lazyPut(() => CreateAccountController(),);
    Get.lazyPut(() => LocationController(),);
   CreateAccountController.selectedCity = CityEntity();
   CreateAccountController.selectedCountry = CountryEntity();
    Future.delayed(Duration.zero, () {
      update();
    });

  }
   final dio = Dio();
   /// Simple POST request with error handling
   Future<void> addFace() async {
     try {
       final preferences = await SharedPreferences.getInstance();
       String? token = preferences.getString('token');

       // ✅ Token validation
       if (token == null || token.isEmpty) {
         debugPrint("⚠️ No token found in SharedPreferences");
         Get.snackbar('Error', 'Please login first.');
         return;
       }
       if (
       nameController.text.trim().isEmpty ||
           familyNameController.text.trim().isEmpty ||
           knowAsController.text.trim().isEmpty ||
           gender == '' ||
           Get.find<UploadController>().selectedImage.value.isEmpty ||
           CreateAccountController.selectedCity.id == null ||
           CreateAccountController.selectedEducation.id == null ||
           CreateAccountController.selectedJob.id == null) {
         Get.snackbar(
           'Error',
           'Please fill in all required fields before submitting.',
         );
         return;
       }
       Get.lazyPut(() => DateController(),);
       // ✅ Format date safely
       final date = Get.find<DateController>().selectedDate;
       final formattedDate =
           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

       // ✅ Prepare request data
       final data = {
         'token':token.toString(),
         'name': nameController.text.trim(),
         'lastName': familyNameController.text.trim(),
         'knownFor': knowAsController.text.trim(),
         'gender': gender,
         'avatar': Get.find<UploadController>().selectedImage.value,
         'hometownId': CreateAccountController.selectedCity.id,
         'educationId': CreateAccountController.selectedEducation.id,
         'jobId': CreateAccountController.selectedJob.id,
         'birthDate': formattedDate,
       };

       // ✅ Send POST request with token in headers
       final response = await dio.post(
         '$baseURL/Api/Faces/add',
         data: data,
         options: Options(
           contentType: Headers.formUrlEncodedContentType, // crucial for .NET backend
         ),
       );

       // ✅ Handle response safely
       if (response.statusCode == 200 && response.data['status'] == 'ok') {
         Get.back();
         nameController.clear();
         familyNameController.clear();
         knowAsController.clear();
         pickedFile!.path == '';
         selectedRadio = -1;
         update();
         Get.snackbar('Success', 'Face added successfully!');
       } else {
         debugPrint("❌ Error: ${response.statusCode} -> ${response.data}");
         Get.snackbar('Error', 'Failed to add face. Please try again.');
       }
     } catch (e, stacktrace) {
       debugPrint("🔥 Exception while adding face: $e");
       debugPrint(stacktrace.toString());
       Get.snackbar('Error', 'An unexpected error occurred.');
     }
   }
   Future<List<FaceEntity>> searchFace(pageKey) async {
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
         'page': pageKey,
         'take': 15,
         'filter': "${nameController.text} ${familyNameController.text}",
       };
       final response = await dio.get(
         '$baseURL/Api/Faces',
         queryParameters: requestData,
       );
       if (response.statusCode == 200) {
         List<dynamic> data = response.data['data']['faces'];
         faceList.addAll(data.map((i)=> FaceEntity.fromJson(i)));
         update();
         return faceList;
       } else {
         Get.snackbar("Error","❌ Error: ${response.statusCode} -> ${response.statusMessage}",);
         return faceList;
       }
     } catch (e, stacktrace) {
       debugPrint("🔥 Exception while fetching memories: $e");
       debugPrint(stacktrace.toString());
       return faceList;
     }
   }

  updateLanguage(int index) {
    selectedLanguage = index;
    update();
  }

  setSelectedRadio(int val) {
    if(val == 1){
      gender = 'male';
    }else if(val ==0){
      gender = 'female';
    }
    selectedRadio = val;
    update();
  }

  textStyleEn(int index) {
    return index == selectedLanguage
        ? appThemeData.textTheme.headlineSmall
        : appThemeData.textTheme.bodyLarge;
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

        actions:[
          Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AppLightColor.strokePositive,width: 1),
              color: AppLightColor.withColor,
            ),
            height: 300.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement
              child:  GetBuilder<SearchBottomController>(
              builder: (controller) {
                return PagingListener(
                  controller: controller.pagingFaceController,
                  builder: (context, state, fetchNextPage) =>
                      PagedListView<int, dynamic>(
                        state: state,
                        fetchNextPage: fetchNextPage,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        builderDelegate: PagedChildBuilderDelegate<dynamic>(
                          itemBuilder: (context, memory, index) {
                            if (index >= faceList.length) return SizedBox(); // safety check
                            FaceEntity face = faceList[index];
                            return ListTileCreate(face: face);
                          },
                          // Optional placeholders for better UX
                          firstPageProgressIndicatorBuilder:
                              (context) => Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: SpinKitFadingCube(
                                duration: Duration(seconds: 1),
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: index.isEven
                                          ? Colors.green
                                          : Colors.blue,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          newPageProgressIndicatorBuilder: (context) =>
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: SpinKitFadingCube(
                                  duration: Duration(seconds: 1),
                                  itemBuilder:
                                      (
                                      BuildContext context,
                                      int index,
                                      ) {
                                    return Center(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: index.isEven
                                              ? Colors.green
                                              : Colors.blue,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          noItemsFoundIndicatorBuilder: (context) => const Center(child: Text("No memories found."),),
                        ),
                      ),
                );
              }),

          ),
        ),
          CreateCancelPerson(),
        ],
    ),
    );
  }
}


