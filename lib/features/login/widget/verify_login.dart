import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/widgets/customButton.dart';
import 'package:test_test_test/config/widgets/four_digit_code_input.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';

import '../../../config/app_icons/app_assets_png.dart';
import '../../../config/app_theme/app_theme.dart';

class VerifyLoginScreen extends StatelessWidget {
  const VerifyLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder<LoginController>(builder: (controller) {
        return ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              width: 280.w,
              height: 300.h,
              child: Image.asset(AppAssetsPng.logo),
            ),
      
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 10),
              width: double.infinity,
              height: 50,
              child: Text(
                "Please Enter Code",
                style: appThemeData.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            FourDigitCodeInput(onCompleted: (String p1) {
              print(p1);
            },
            ),
            SizedBox(height: 10,),
            CustomElevatedButton(onPressed: () {
              controller.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }, textColor: Colors.white, color: Colors.indigo, title: 'Verify-Login', height: 40.h, width: 300.w,),

          ],
        );
      }),
    );
  }
}
