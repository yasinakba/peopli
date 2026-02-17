import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';


import '../../../config/app_route/route_names.dart';
import '../../profile_screen/controller/profile_controller.dart';

class LoginController extends GetxController{
  PageController pageController = PageController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obSecureText = true;
  bool loading = false;

  share() async {
    await Share.share("com.example.peopli");
  }
  final dio = Dio();

  Future<void> signIn() async {
    loading = true;
    update();
    final username = userNameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      loading = false;
      Get.snackbar("Error","Username or password is empty");
      update();
      return;
    }

    try {

      final response = await dio.post(
        "$baseURL/Api/login",
        queryParameters: {
          "username": username,
          "password": password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType, // crucial for .NET backend
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        loading=false;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', response.data['data']);
        Get.find<ProfileController>().getCurrentAccount();
        update();
        Get.toNamed(NamedRoute.routeHomeScreen);
      } else {
        loading=false;
        update();
        Get.showSnackbar(GetSnackBar(title: 'Error',message: response.data['data'],duration: Duration(seconds: 2)));
      }
    } on DioException catch (e) {
      loading=false;
      update();
      Get.snackbar("Error","POST error: ${e.response?.statusCode} - ${e.message}");
    }
  }
  Future<void> changePassword() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    loading = true;
    update();

    if(token == null){
      Get.snackbar('Error', 'Please register first');
    }
    if (oldPasswordController.text.isEmpty || newPasswordController.text.isEmpty ) {
      loading = false;
      Get.snackbar("Error","Username or password is empty");
      update();
      return;
    }

    try {

      final response = await dio.post(
        "$baseURL/Api/change-password",
        queryParameters: {
          "token": token,
          "oldPassword": oldPasswordController.text,
          "newPassword": newPasswordController.text,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType, // crucial for .NET backend
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        pageController.jumpToPage(0);
        update();
      } else {
        loading=false;
        update();
        Get.showSnackbar(GetSnackBar(title: 'Error',message: response.data['data'],duration: Duration(seconds: 2)));
      }
    } on DioException catch (e) {
      loading=false;
      update();
      Get.snackbar("Error","POST error: ${e.response?.statusCode} - ${e.message}");
    }
  }



}