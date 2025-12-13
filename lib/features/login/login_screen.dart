import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';
import 'package:test_test_test/features/login/widget/forget-password.dart';
import 'package:test_test_test/features/login/widget/verify_login.dart';
import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: GetBuilder<LoginController>(builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                    width: 280.w,
                    height: 300.h,
                    child: Image.asset(AppAssetsPng.logo)),
              ),


              // Padding(
              //   padding: const EdgeInsets.only(top: 50,bottom: 10),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 50,
              //     child: Text("Please Enter PhoneNumber",style: appThemeData.textTheme.titleLarge,textAlign: TextAlign.center,),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                          width: 1, color: AppLightColor.fillButton)),
                  child: TextFormField(
                    controller: controller.userNameController,
                    style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'UserName',
                      labelStyle: appThemeData.textTheme.bodyLarge,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppLightColor.strokePositive,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                          width: 1, color: AppLightColor.fillButton)),
                  child: TextFormField(
                    obscureText: controller.obSecureText,
                    controller: controller.passwordController,
                    style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        controller.obSecureText = !controller.obSecureText;
                        controller.update();
                      },
                          icon: Icon(controller.obSecureText
                              ? FrinoIcons.f_eye
                              : FrinoIcons.f_eye_slash)),
                      filled: true,
                      labelText: 'Password',
                      labelStyle: appThemeData.textTheme.bodyLarge,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppLightColor.strokePositive,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: controller.loading ? LoadingWidget() : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppLightColor.textBlueColor,
                          shape: StadiumBorder()),
                      onPressed: () {
                        controller.signIn();
                      },
                      child: Text("Login",
                        style: theme.textTheme.labelMedium!.copyWith(
                            color: Colors.white),)),
                ),
              ),
              //Richtext
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(NamedRoute.routeAccountScreen,);
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an Account? ",
                          style: appThemeData.textTheme.headlineLarge,
                          children: [

                            TextSpan(
                              text: " Signup ",
                              style: appThemeData.textTheme.headlineLarge!
                                  .copyWith(color: AppLightColor.textBlueColor),
                            ),

                          ]
                      ),

                    ),
                  ),
                ),
              ),


              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          controller.pageController.jumpToPage(1);
                        },
                        child: Text(" Forgot your password? ",
                          style: appThemeData.textTheme.headlineLarge!.copyWith(
                              color: AppLightColor.textBlueColor),)),
                  ))
            ],
          );
        }));
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
          titleStyle: TextStyle(fontSize: 18,color: Colors.red.shade400),
          middleText: 'Are you sure you want to exit the app?',
          middleTextStyle: TextStyle(fontSize: 16,color: Colors.grey.shade900),
          backgroundColor: Colors.blueGrey[100],
          radius: 15,
          textCancel: 'Cancel',
          cancelTextColor: Colors.red,
          onCancel: () {},
          textConfirm: 'Confirm',
          confirmTextColor: Colors.white,
          onConfirm: () {
            SystemNavigator.pop();
          },
          buttonColor: Colors.green,
          barrierDismissible: true, // for blur with click on everywhere
          actions: [
            // Icon(Icons.tab)
          ],
        );
      },
      child: GetBuilder<LoginController>(builder: (logic) {
        return PageView.builder(
          controller: logic.pageController,
          itemCount: loginWidget.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return loginWidget[index];
          },
        );
      }),
    );
  }
}

List<Widget> loginWidget = [
  LoginView(),
  VerifyLoginScreen(),
  ForgetPassword(),
];
