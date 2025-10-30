import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_png.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
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
                    border: Border.all(width: 1, color: AppLightColor.fillButton)),
                child: TextFormField(
                  style: TextStyle(
                      height: 1, fontWeight: FontWeight.bold, color: Colors.blue),
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Enter Your Email Address',
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
                      Get.toNamed(NamedRoute.routeLoginScreen);
                    },
                    child: Text("Send")),
              ),
            ),
            //Richtext

          ],
        ));
  }
}
