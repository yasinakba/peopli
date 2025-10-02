
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../feature_location/controller/location_controller.dart';
import '../widget/create_cancel_person.dart';
import '../widget/listTile_create.dart';

class CreatePersonController extends GetxController {
   TextEditingController nameController = TextEditingController();
   TextEditingController familyNameController = TextEditingController();
   TextEditingController knowAsController = TextEditingController();
   TextEditingController locationController = TextEditingController();
   TextEditingController dateTimeController = TextEditingController();
   int selectedRadio = 0;
   int selectedLanguage = 0;
   File? pickedFile;
   String gender = '';
   @override void onInit() {
    super.onInit();
    Get.lazyPut(() => CreateAccountController(),);
    Get.lazyPut(() => LocationController(),);
   CreateAccountController.selectedCity = LocationController.cityList[0];
   CreateAccountController.selectedCountry = Get.find<LocationController>().countryList[0];
    Future.delayed(Duration.zero, () {
      update();
    });

  }
   final dio = Dio();
   /// Simple POST request with error handling
   Future<void> addFace() async {
     try {
       final preferences = await SharedPreferences.getInstance();
       final token = preferences.getString('token');

       if (token == null) {
         debugPrint("⚠️ No token found in SharedPreferences");
         return;
       }
       var date = selectedDate!;
       final response = await dio.post(
         'https://api.peopli.ir/Api/Faces/add',
         queryParameters: {
           'token':token,
           'name':nameController.text,
           'lastName':familyNameController.text,
           'knownFor':knowAsController.text,
           'gender':gender,
           'avatar':base64String,
           'hometownId':CreateAccountController.selectedCity.id,
           'educationId':CreateAccountController.selectedEducation.id,
           'jobId':CreateAccountController.selectedJob.id,
           'birthDate':"${date.year}${date.month}${date.day}",
         }
       );
       if (response.statusCode == 200 && response.data['status'] == 'ok') {
         print('test');print(response.data);print(response.statusCode);
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

  updateLanguage(int index) {
    selectedLanguage = index;
    update();
  }

  setSelectedRadio(int val) {
    if(val == 1){
      gender == 'male';
    }else if(val ==0){
      gender == 'female';
    }
    selectedRadio = val;
    update();
  }

  textStyleEn(int index) {
    return index == selectedLanguage
        ? appThemeData.textTheme.headlineSmall
        : appThemeData.textTheme.bodyLarge;
  }

   String? base64String;
   uploadImage() async {
     final  picker = ImagePicker();
     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
     pickedFile=File(pickedImage!.path);
     if (pickedImage != null) {
       // Read file as bytes
       final bytes = await File(pickedImage.path).readAsBytes();

       // Convert to Base64
       base64String = base64Encode(bytes);

       print("📦 Base64 String: $base64String");
     }
     update();
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


