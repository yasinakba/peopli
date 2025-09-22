import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_test_test/features/create_person/widget/gender-person.dart';
import 'package:test_test_test/features/create_person/widget/information-Person.dart';
import 'package:test_test_test/features/create_person/widget/save_person.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_theme/app_theme.dart';
import '../edit_person/widget/textField_create.dart';
import 'controller/create_perxon_controller.dart';


class CreatePersonScreen extends GetView<CreatePersonController> {
  const CreatePersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreatePersonController>(builder: (controller) =>ListView(
        children: [
          //CircleImage
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 5),
            child: Align(
                alignment: Alignment.center,
                child: GetBuilder<CreatePersonController>(builder: (controller) {

                  return Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppLightColor.elipsFill,
                      image:controller.pickedFile==null?null: DecorationImage(image: FileImage(controller.pickedFile!),fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(1000)),
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
                  padding: const EdgeInsets.only(right: 20,left: 20),
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
                          controller.uploadImage();
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

                GenderPerson(),
                //information
                 InformationPerson(),
                //SavePerson
                SavePerson()
              ],
            ),
          )
        ],
      ) )
    );
  }
}
