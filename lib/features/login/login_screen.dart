import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/widgets/customButton.dart';
import 'package:test_test_test/config/widgets/custom_text_form_field.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';
import 'package:test_test_test/features/login/widget/forget-password.dart';
import 'package:test_test_test/features/login/widget/verify_login.dart';
import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';
import '../create_account/widget/custom_text_form_field_password.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                width: 280.w,
                height: 300.h,
                child: Image.asset(AppAssetsPng.logo),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 50,bottom: 10),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 50,
              //     child: Text("Please Enter PhoneNumber",style: appThemeData.textTheme.titleLarge,textAlign: TextAlign.center,),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(width: 1, color: AppLightColor.fillButton),
                ),
                child: CustomTextFormField(controller: controller.userNameController, title: 'UserName'),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(width: 1, color: AppLightColor.fillButton),
                ),
                child:CustomTextFormFieldPassword(controller: controller.passwordController, title: 'password',),
              ),

              controller.loading
                  ? LoadingWidget()
                  : CustomElevatedButton(
                      color: Colors.indigo,
                      textColor: Colors.white,
                      title: 'Login',
                      height: 40.h,
                      width: 300.w,
                      onPressed: () {
                        controller.signIn();
                      },
                    ),
              //Richtext
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(NamedRoute.routeAccountScreen);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an Account? ",
                      style: appThemeData.textTheme.headlineLarge,
                      children: [
                        TextSpan(
                          text: " Signup ",
                          style: appThemeData.textTheme.headlineLarge!.copyWith(
                            color: AppLightColor.textBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text(
                    " Forgot your password? ",
                    style: appThemeData.textTheme.headlineLarge!.copyWith(
                      color: AppLightColor.textBlueColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.defaultDialog(
          title: 'Pay attention',
          titleStyle: TextStyle(fontSize: 18, color: Colors.black),
          middleText: 'Are you sure you want to exit the app?',
          middleTextStyle: TextStyle(fontSize: 16, color: Colors.grey.shade900),
          backgroundColor: Colors.blueGrey[100],
          radius: 15,
          textCancel: 'Cancel',
          cancelTextColor: Colors.black,
          onCancel: () {},
          textConfirm: 'Confirm',
          confirmTextColor: Colors.white,
          onConfirm: () {
            SystemNavigator.pop();
          },
          buttonColor: Colors.green,
          barrierDismissible: true,
          // for blur with click on everywhere
          actions: [
            // Icon(Icons.tab)
          ],
        );
      },
      child: GetBuilder<LoginController>(
        builder: (logic) {
          return PageView.builder(
            controller: logic.pageController,
            itemCount: loginWidget.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return loginWidget[index];
            },
          );
        },
      ),
    );
  }
}

List<Widget> loginWidget = [LoginView(), VerifyLoginScreen(), ForgetPassword()];
