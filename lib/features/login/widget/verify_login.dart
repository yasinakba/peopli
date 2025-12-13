import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_png.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';

class VerifyLoginScreen extends StatelessWidget {
  const VerifyLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder<LoginController>(builder: (controller) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 280.w,
                height: 300.h,
                child: Image.asset(AppAssetsPng.logo),
              ),
            ),
      
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Text(
                  "Please Enter Code",
                  style: appThemeData.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppLightColor.fillButton),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: TextFormField(
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Code',
                    labelStyle: appThemeData.textTheme.bodyLarge,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
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
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    Get.toNamed(NamedRoute.routeAccountScreen);
                  },
                  child: Text("Verify_Login"),
                ),
              ),
            ),
      
            //
            // Padding(
            //   padding: const EdgeInsets.only(top: 35),
            //   child: RichText(text: TextSpan(
            //       text: "ورود به نرم افزار به معنای  ",
            //       style:TextStyle(color: Colors.red,fontSize: 18),
            //       children:<TextSpan> [
            //         TextSpan(
            //             text: "پذیرش قوانین است",
            //             style: TextStyle(color: Colors.greenAccent,fontSize: 18)
            //         )
            //       ]
            //   )
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
