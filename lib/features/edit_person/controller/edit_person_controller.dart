
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';
import '../../create_person/widget/location.dart';
import '../widget/create_cancel_person.dart';
import '../widget/listTile_create.dart';

class EditPersonController extends GetxController {
  List listData=["Elementary","Diploma",'Bachelors degree','Masters degree','P.H.D'];
  List listJobs=["Teacher","Employee","manual worker",'Actor','Singer','programmer','The architect','politician'];
  int selectedRadio = 0;
  int selectedLanguage = 0;
  File? pickedFile;
  String education="";
  String jobs="";

  @override
  void onInit() {

  }



  updateLAnguage(int index) {
    selectedLanguage = index;
    update();
  }

  setSelectedRadio(int val) {
    selectedRadio = val;
    update();
  }

  textStyleEn(int index) {
    return index == selectedLanguage
        ? appThemeData.textTheme.headlineSmall
        : appThemeData.textTheme.bodyLarge;
  }
 String? base64String;
  uploadImage() async {
    final  picker = ImagePicker();
// Pick an image.
   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    pickedFile=File(pickedImage!.path);
    if (pickedImage != null) {
      // Read file as bytes
      final bytes = await File(pickedImage.path).readAsBytes();

      // Convert to Base64
      base64String = base64Encode(bytes);

      print("📦 Base64 String: $base64String");
    }
    update();
  }



  openDialog(context){
      showDialog(context: context, builder: (context)=>AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
         title: Text("Education",style: appThemeData.textTheme.headlineSmall,),
         backgroundColor: AppLightColor.backgoundPost,

        actions:[Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.bookmark_add,color: AppLightColor.fillButton,),
                    subtitle: Text("Please select the desired degree",style: appThemeData.textTheme.bodyMedium,),
                    onTap: (){
                      education=listData[index];
                      Get.back();
                      update();
                    },
                    title:Text(listData[index],style: appThemeData.textTheme.headlineSmall,),
                    selectedColor: AppLightColor.elipsFill,
                    focusColor: AppLightColor.strokePositive,


                  ),
                  //divider
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: AppLightColor.strokePositive,
                    ),
                  )
                ],
              );
            },
          ),
        )]
    ));



    }

  openDialogJobs(context){
    showDialog(context: context, builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        title: Text("Jobs",style: appThemeData.textTheme.headlineSmall,),
        backgroundColor: AppLightColor.backgoundPost,

        actions:[Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listJobs.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person_add,color: AppLightColor.fillButton,),
                    subtitle: Text("Please select the desired degree",style: appThemeData.textTheme.bodyMedium,),
                    onTap: (){
                      jobs=listJobs[index];
                      Get.back();
                      update();
                    },
                    title:Text(listJobs[index],style: appThemeData.textTheme.headlineSmall),
                    selectedColor: AppLightColor.elipsFill,
                    focusColor: AppLightColor.strokePositive,


                  ),
                  //divider
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: AppLightColor.strokePositive,
                    ),
                  )
                ],
              );
            },
          ),
        )]
    ));



  }


  //openDialogPerson
  openDialogPerson(context){
    showDialog(context: context, builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Do you mean?",style: appThemeData.textTheme.headlineSmall,),
            Text("23 Result",style: appThemeData.textTheme.labelLarge,),
          ],
        ),
        backgroundColor: AppLightColor.backgoundPost,

        actions:[Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AppLightColor.strokePositive,width: 1),
              color: AppLightColor.withColor,
            ),
            height: 300.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement

              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTileCreate(),
                      //divider

                    ],
                  );
                },
              ),

          ),
        ),
          CreateCancelPerson()

        ],


    )

    );



  }

  //location
  editOpenDialogLocation(context){
    showDialog(context: context, builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        title: Text("Location",style: appThemeData.textTheme.headlineSmall,),
        backgroundColor: AppLightColor.backgoundPost,
        actions:[LocationScreen(),
          LocationCity(),
          Align(
              alignment: Alignment.center,
              child: CustomElevatedButton(onPressed: (){}, textColor: AppLightColor.withColor, color: AppLightColor.textBlueColor, title: "Save", height: 40.h, width: 120.w))
        ]
    ));



  }
}


