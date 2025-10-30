import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/edit_person/widget/information.dart';
import 'package:test_test_test/features/edit_person/widget/save_person.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';

import '../../config/app_theme/app_theme.dart';
import '../create_account/widget/gender.dart';
import '../create_person/widget/textField_create.dart';
import 'controller/edit_person_controller.dart';


class EditPersonScreen extends GetView<EditPersonController> {
  const EditPersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<EditPersonController>(builder: (controller) =>ListView(
        children: [
          //CircleImage
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 5),
            child: Align(
                alignment: Alignment.center,
                child: GetBuilder<UploadController>(builder: (controller) {
                  return Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image:controller.pickedFile==null?DecorationImage(image:NetworkImage('$baseImageURL/noavatar.png'),fit: BoxFit.cover): DecorationImage(image: FileImage(File(controller.pickedFile!.path)),fit: BoxFit.cover),
                    ),

                  );
                },)
            ),
          ),
          SizedBox(
            width: 292.w,
            child: Column(
              children: [
                //En && AddPhotoes
                Padding(
                  padding: const EdgeInsets.only(right: 50,left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [

                          InkWell(
                            onTap: (){controller.updateLAnguage(0);},
                            child: Text("EN",style: controller.textStyleEn(0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Text("|"),
                          ),
                          InkWell(
                            onTap: (){controller.updateLAnguage(1);},
                            child: Text("FA",style: controller.textStyleEn(1),),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Get.find<UploadController>().uploadImage();
                        },
                        child: Text("Add Photos",style: appThemeData.textTheme.bodyLarge,),
                      ),
                    ],

                  ),
                ),
                //textField
                SizedBox(
                  height: 200.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFieldCreate(labelText: 'name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFieldCreate(labelText: 'family'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFieldCreate(labelText: 'family name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFieldCreate(labelText: 'Known as',),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFieldCreate(labelText: 'Date of birth'),
                      ),
                    ],
                  ),
                ),

                //Gender

                Gender(),
                //information
                 Information(),
                //SavePerson
                EditSavePerson()
              ],
            ),
          )
        ],
      ) )
    );
  }
}
