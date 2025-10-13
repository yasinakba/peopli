import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../edit_profile/controller/edit_profile_controller.dart';
import '../../feature_location/controller/location_controller.dart';
import '../widget/create_cancel_person.dart';
import '../widget/listTile_create.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as DioPackage;

class CreatePersonController extends GetxController {
   TextEditingController nameController = TextEditingController();
   TextEditingController familyNameController = TextEditingController();
   TextEditingController knowAsController = TextEditingController();
   TextEditingController locationController = TextEditingController();
   TextEditingController dateTimeController = TextEditingController();
   int selectedRadio = 0;
   int selectedLanguage = 0;
   XFile? pickedFile;
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
   // Future<void> addFace() async {
   //   // try {
   //     final preferences = await SharedPreferences.getInstance();
   //     String? token = preferences.getString('token');
   //
   //     // ✅ Step 1: Token validation
   //     if (token == null || token.isEmpty) {
   //       debugPrint("⚠️ No token found in SharedPreferences");
   //       Get.snackbar('Error', 'Please login first.');
   //       return;
   //     }
   //
   //     // ✅ Step 2: Input validation
   //     if (nameController.text.trim().isEmpty ||
   //         familyNameController.text.trim().isEmpty ||
   //         knowAsController.text.trim().isEmpty ||
   //         gender == null ||
   //         selectedImage.value == '' ||
   //         CreateAccountController.selectedCity.id == null ||
   //         CreateAccountController.selectedEducation.id == null ||
   //         CreateAccountController.selectedJob.id == null ||
   //         selectedDate == null) {
   //       Get.snackbar(
   //         'Error',
   //         'Please fill in all required fields before submitting.',
   //       );
   //       return;
   //     }
   //
   //     // ✅ Step 3: Format date safely
   //     final date = selectedDate!;
   //     final formattedDate =
   //         "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
   //
   //     // ✅ Step 5: Send request
   //     final response = await dio.post(
   //       'https://api.peopli.ir/Api/Faces/add',
   //       data: {
   //         'token': token.toString(),
   //         'name': nameController.text.trim(),
   //         'lastName': familyNameController.text.trim(),
   //         'knownFor': knowAsController.text.trim(),
   //         'gender': gender,
   //         'avatar': selectedImage.value,
   //         'hometownId': CreateAccountController.selectedCity.id,
   //         'educationId': CreateAccountController.selectedEducation.id,
   //         'jobId': CreateAccountController.selectedJob.id,
   //         'birthDate': formattedDate,
   //       },
   //       // options: Options(headers: headers),
   //     );
   //    print(response.data['data']);
   //     // ✅ Step 6: Handle response
   //     if (response.statusCode == 200 && response.data['status'] == 'OK') {
   //       debugPrint('✅ Face added successfully: ${response.data}');
   //       Get.snackbar('Success', 'Face added successfully!');
   //     } else {
   //       debugPrint("❌ Error: ${response.statusCode} -> ${response.statusMessage}");
   //       Get.snackbar('Error', 'Failed to add face. Please try again.');
   //     }
   //   // } catch (e, stacktrace) {
   //   //   debugPrint("🔥 Exception while adding face: $e");
   //   //   debugPrint(stacktrace.toString());
   //   //   Get.snackbar('Error', 'An unexpected error occurred.');
   //   // }
   // }
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

       // ✅ Input validation
       if (nameController.text.trim().isEmpty ||
           familyNameController.text.trim().isEmpty ||
           knowAsController.text.trim().isEmpty ||
           gender == null ||
           selectedImage.value.isEmpty ||
           CreateAccountController.selectedCity.id == null ||
           CreateAccountController.selectedEducation.id == null ||
           CreateAccountController.selectedJob.id == null ||
           selectedDate == null) {
         Get.snackbar(
           'Error',
           'Please fill in all required fields before submitting.',
         );
         return;
       }

       // ✅ Format date safely
       final date = selectedDate!;
       final formattedDate =
           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

       // ✅ Prepare request data
       final data = {
         'token':token.toString(),
         'name': nameController.text.trim(),
         'lastName': familyNameController.text.trim(),
         'knownFor': knowAsController.text.trim(),
         'gender': gender,
         'avatar': selectedImage.value,
         'hometownId': CreateAccountController.selectedCity.id,
         'educationId': CreateAccountController.selectedEducation.id,
         'jobId': CreateAccountController.selectedJob.id,
         'birthDate': formattedDate,
       };

       // ✅ Send POST request with token in headers
       final response = await dio.post(
         'https://api.peopli.ir/Api/Faces/add',
         data: data,
         options: Options(
           contentType: Headers.formUrlEncodedContentType, // crucial for .NET backend
         ),
       );

       // ✅ Handle response safely
       if (response.statusCode == 200 && response.data['status'] == 'ok') {

         debugPrint('✅ Face added successfully: ${response.data}');
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

   var isUploading = false.obs;
   // RxString selectedImage = 'usericon.png'.obs;
   RxString selectedImage = 'usericon.png'.obs;
   final String uploadUrl = "https://api.peopli.ir/uploader";
   Future<void> uploadImage() async {
     final picker = ImagePicker();

     // Pick an image
     final file = await picker.pickImage(source: ImageSource.gallery);

     if (file == null) {
       print("No file selected");
       return;
     }
     pickedFile = file;
     File imageFile = File(file.path);

     // Create multipart request
     var request = http.MultipartRequest("POST", Uri.parse(uploadUrl));

     // "file" must match your IFormFile parameter name
     request.files.add(
       await http.MultipartFile.fromPath("file", imageFile.path),
     );

     // Send request
     var response = await request.send();

     if (response.statusCode == 200) {
     var responseBody= await response.stream.bytesToString();
     var data = await json.decode(responseBody);
     selectedImage.value = data['data']; // for ex// ample
     update();
     final respStr = await response.stream.bytesToString();
       print("Upload success: $respStr");
     } else {
       print("Upload failed: ${response.statusCode}");
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


