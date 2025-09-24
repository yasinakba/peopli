import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';
import 'package:test_test_test/features/splashscreen/controllers/login_controller.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
 final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: GetBuilder<LoginController>(builder: (controller) {
          return ListView(
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
                    controller:controller.passwordController,
                    style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    decoration: InputDecoration(
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
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppLightColor.textBlueColor,
                          shape: StadiumBorder()),
                      onPressed: () {
                        controller.signIn();
                      },
                      child: Text("Login",style: theme.textTheme.labelMedium!.copyWith(color: Colors.white),)),
                ),
              ),
              //Richtext
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(NamedRoute.routeAccountScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Dont Have Account? ",
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
                          Get.toNamed(NamedRoute.routeForgetPassword);
                        },
                        child: Text(" Forgot your password? ",
                          style: appThemeData.textTheme.headlineLarge!.copyWith(
                              color: AppLightColor.textBlueColor),)),
                  )),
            ],
          );
        }));
  }
}
