import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/education_cotnroller.dart';
import 'package:test_test_test/features/profile_screen/entity/user_entity.dart';
import 'package:dio/dio.dart'as DioPackage;

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';

class EditProfileController extends GetxController {
  UserEntity currentUser = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    fillProperties();
  }

  TextEditingController displayController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  int selectedRadio = 0;
  int selectedLanguage = 0;
  File? pickedFile;
  String education = "";
  String jobs = "";
  final dio = Dio();

  fillProperties() {
    Get.lazyPut(() => CreateAccountController());
    Get.lazyPut(() => EducationController());

    if (currentUser != null) {
      displayController.text = currentUser.displayName;
      userNameController.text = currentUser.username;
      emailController.text = currentUser.email ?? "";
      selectedDate = currentUser.birthdate;

      if (currentUser.birthdate != null) {
        final bd = currentUser.birthdate!;
        dateTimeController.text = "${bd.year}/${bd.month}/${bd.day}";
      } else {
        dateTimeController.clear();
      }

      final educationCtrl = Get.find<EducationController>();
      final selected = educationCtrl.educationList.firstWhereOrNull(
        (element) => element.id == currentUser.educationId,
      );
      if (selected != null) {
        CreateAccountController.selectedEducation = selected;
      }

      update();
      Future.delayed(Duration.zero, () {
        Get.find<CreateAccountController>().update();
        Get.find<EducationController>().update();
      });
    }
  }
  Future<void> editProfile() async {

      // 1️⃣ Input validation
      if (userNameController.text.isEmpty ||
          displayController.text.isEmpty ||
          emailController.text.isEmpty ||
          CreateAccountController.selectedCity.id == null ||
          selectedDate == null ||
          selectedImage.value == null ||
          CreateAccountController.selectedEducation.id == null) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: 'Please fill in all required information',
            duration: Duration(seconds: 3),
          ),
        );
        return; // stop execution if validation fails
      }

      // 2️⃣ Optional: further email format validation
      if (!GetUtils.isEmail(emailController.text.trim())) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: 'Please enter a valid email address',
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // 3️⃣ Proceed with API call
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final t = preferences.get('token');
      if (t == null) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: 'User token not found',
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

    // 3️⃣ Prepare request
    try {
      final response = await dio.post(
        'https://api.peopli.ir/Api/Account/edit-profile',
        queryParameters: {
          "username": userNameController.text,
          "displayName": displayController.text,
          "avatar": selectedImage.value,
          "email": emailController.text,
          "cityId": CreateAccountController.selectedCity.id,
          "birthDate": "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
          "educationId": CreateAccountController.selectedEducation.id,
          "token":t.toString(),
        },
      );

      print(response.data);
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        Get.toNamed(NamedRoute.routeLoginScreen);
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: 'Failed to update profile',
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
        debugPrint("${e}");
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Something went wrong: $e',
          duration: Duration(seconds: 3),
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

  updateLanguage(int index) {
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
  var isUploading = false.obs;
  var selectedImage = 'usericon.png'.obs;
  uploadImage({required context, required XFile image}) async {
    isUploading.value = true;
    // try {
      DioPackage.FormData formData;
      var response;
      if (!kIsWeb) {
        try{
        formData = DioPackage.FormData.fromMap(
            {'file': await DioPackage.MultipartFile.fromFile(image.path)});
        print(image.path);
        response = await dio.post("https://api.peopli.ir/uploader/image", data: formData);
        print(response.data);
        if (response.statusCode == 200) {
          var status = response.data["status"];
          var data = response.data["data"];
          if (status == "ok") {
            selectedImage.value = data;
            selectedImage.refresh();
          }
        } else {
          Get.snackbar('خطا در هنگام آپلود', response.statusMessage??'');
        }

        isUploading.value = false;
      } catch (e) {
      print(e.toString());
      Get.snackbar('خطا در هنگام آپلود', e.toString());
      isUploading.value = false;
    }
      }
      // } else {
        // Uint8List content = await image.readAsBytes();
        // DioPackage.FormData formData = DioPackage.FormData.fromMap({
        //   "file": DioPackage.MultipartFile.fromBytes(content, filename: image.name)
        // });
        // response = await dio.post('https://api.peopli.ir/Api/uploads',
        //     data: formData,
        //     options: Options(headers: {"Content-Type": "multipart/form-data"}));
      }

    //   if (response.statusCode == 200) {
    //     var status = response.data["status"];
    //     var data = response.data["data"];
    //     if (status == "ok") {
    //       selectedImage.value = data;
    //       selectedImage.refresh();
    //     }
    //   } else {
    //     Get.snackbar('خطا در هنگام آپلود', response.statusM);
    //   }
    //
    //   isUploading.value = false;
    // } catch (e) {
    //   print(e.toString());
    //   Get.snackbar('خطا در هنگام آپلود', e.toString());
    //   isUploading.value = false;
    // }

  selectImageFromGallery(context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1080);
    if (image != null) {
      await Get.find<EditProfileController>().uploadImage(context: context, image: image);
      selectedImage = Get.find<EditProfileController>().selectedImage;
      selectedImage.refresh();
    }
  }
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
                      //divider
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
