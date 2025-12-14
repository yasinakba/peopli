import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/widgets/customButton.dart';
import 'package:test_test_test/features/create_account/widget/custom_textField.dart';
import 'package:test_test_test/features/create_account/widget/custom_text_form_field_password.dart';
import 'package:test_test_test/features/login/controller/login_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_png.dart';
import '../../../config/widgets/custom_text_form_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: GetBuilder<LoginController>(builder: (controller) {
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
               Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                          width: 1, color: AppLightColor.fillButton)),
                  child:CustomTextFormField(title: 'Enter Your Email Address', controller: controller.emailController,),
                ),

               CustomElevatedButton(
                 textColor: Colors.white,
                   color: Colors.indigo,
                   height: 40.h,
                   width: 300.w,
                   onPressed: () {
                     controller.pageController.jumpToPage(0);
                   },
                   title:  "Send"),
              //Richtext

            ],
          );
        }));
  }
}
