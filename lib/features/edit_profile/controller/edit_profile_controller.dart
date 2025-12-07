import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/feature_job_and_education/controller/education_cotnroller.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';
import 'package:test_test_test/features/profile_screen/entity/user_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';

class EditProfileController extends GetxController {
  UserEntity currentUser = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    checkInternet();
    Get.lazyPut(() => DateController(),);
    fillProperties();
  }

  TextEditingController displayController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  int selectedRadio = 0;
  int selectedLanguage = 0;
  String education = "";
  String jobs = "";
  final dio = Dio();

  fillProperties() {
    Get.lazyPut(() => CreateAccountController());
    Get.lazyPut(() => EducationController());

      displayController.text = currentUser.displayName;
      userNameController.text = currentUser.username;
      emailController.text = currentUser.email ?? "";
      Get.find<DateController>().selectedDate == currentUser.birthdate;

      if (currentUser.birthdate != null) {
        dateTimeController.text = Get.find<DateController>().selectedDate.timeZoneName;
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
  Future<void> editProfile() async {

      // 1️⃣ Input validation
      if (userNameController.text.isEmpty ||
          displayController.text.isEmpty ||
          emailController.text.isEmpty ||
          CreateAccountController.selectedCity.id == '' ||
          Get.find<DateController>().selectedDate == '' ||
          Get.find<UploadController>().selectedImage.value == '' ||
          CreateAccountController.selectedEducation.id == '') {
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
        '$baseURL/Api/Account/edit-profile',
        queryParameters: {
          "username": userNameController.text,
          "displayName": displayController.text,
          "avatar": Get.find<UploadController>().selectedImage.value,
          "email": emailController.text,
          "cityId": CreateAccountController.selectedCity.id,
          "birthDate": Get.find<DateController>().selectedDate,
          "educationId": CreateAccountController.selectedEducation.id,
          "token":t.toString(),
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
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
      debugPrint("e");
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Something went wrong: $e',
          duration: Duration(seconds: 3),
        ),
      );
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
