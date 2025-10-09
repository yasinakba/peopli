import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:test_test_test/features/create_person/widget/gender-person.dart';
import 'package:test_test_test/features/create_person/widget/information-Person.dart';
import 'package:test_test_test/features/create_person/widget/save_person.dart';

import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_theme/app_theme.dart';
import '../edit_person/widget/textField_create.dart';
import 'controller/create_person_controller.dart';


class CreatePersonScreen extends GetView<CreatePersonController> {
  final CreatePersonController createPersonController = Get.put(CreatePersonController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreatePersonController>(builder: (controller) =>CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
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
                        shape: BoxShape.circle,
                      ),

                    );
                  },)
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
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
                              onTap: (){controller.updateLanguage(0);},
                              child: Text("EN",style: controller.textStyleEn(0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: Text("|"),
                            ),
                            InkWell(
                              onTap: (){controller.updateLanguage(1);},
                              child: Text("FA",style: controller.textStyleEn(1),),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            controller.selectImageFromGallery(context);
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
                          child: TextFieldCreate(labelText: 'userName', controller: controller.nameController,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFieldCreate(labelText: 'family name', controller: controller.familyNameController,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFieldCreate(labelText: 'Known as', controller: controller.knowAsController,),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 10,),
                          child: Container(
                            width: 290.w,
                            height: 32.h,
                            padding: EdgeInsetsDirectional.only(
                              start: 10.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedDate != null
                                      ? DateFormat(
                                    'yyyy/MM/dd – HH:mm',
                                  ).format(
                                    controller.selectedDate!,
                                  )
                                      : "No date selected",
                                  style:
                                  appThemeData.textTheme.bodySmall,
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.pickDateTime(context);
                                  },
                                  icon: Icon(
                                    Icons.calendar_today,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
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
            ),
          )
        ],
      ) )
    );
  }
}
