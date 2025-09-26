
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/customButton.dart';
import '../../create_person/widget/location.dart';


class EditProfileController extends GetxController {

  @override
  void onInit() {
    super.onInit();

  }
  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  List listData=["Elementary","Diploma",'Bachelors degree','Masters degree','P.H.D'];
  List listJobs=["Teacher","Employee","manual worker",'Actor','Singer','programmer','The architect','politician'];
  int selectedRadio = 0;
  int selectedLanguage = 0;
  File? pickedFile;
  String education="";
  String jobs="";
  final dio = Dio();

  Future<void> editProfile()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
   String? token = preferences.getString('token');
    final response = dio.post('https://api.peopli.ir/Api/Account/edit-profile',queryParameters: {
      'token':token,
      'username':userNameController.text,
      'displayName':"${nameController.text} ${familyController.text}",
      'avatar':pickedFile!.path,
      'email':emailController.text,
      'cityId':CreateAccountController.selectedCity.id,
      // 'birthDate':CreateAccountController.,
      'educationId':CreateAccountController.selectedEducation.id,
    });
  }

  DateTime? selectedDate;

  void pickDateTime(context) async {
    DateTime now = DateTime.now();
    DateTime initialDate = DateTime(now.year - 18); // default: 18 years ago
    DateTime firstDate = DateTime(1900); // earliest selectable year
    DateTime lastDate = now; // latest selectable date: today

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: "Select your birth date",
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateTimeController.text = picked.toString();
      update();
      print("Selected birth date: $picked");
    }
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

  uploadImage() async {
    final  picker = ImagePicker();
// Pick an image.
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    pickedFile=File(pickedImage!.path);
    update();
  }



  // openDialog(context){
  //   showDialog(context: context, builder: (context)=>AlertDialog(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10.0))
  //       ),
  //       title: Text("Education",style: appThemeData.textTheme.headlineSmall,),
  //       backgroundColor: AppLightColor.backgoundPost,
  //
  //       actions:[Container(
  //         height: 300.0, // Change as per your requirement
  //         width: 300.0, // Change as per your requirement
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: listData.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Column(
  //               children: [
  //                 ListTile(
  //                   leading: Icon(Icons.bookmark_add,color: AppLightColor.fillButton,),
  //                   subtitle: Text("Please select the desired degree",style: appThemeData.textTheme.bodyMedium,),
  //                   onTap: (){
  //                     education=listData[index];
  //                     Get.back();
  //                     update();
  //                   },
  //                   title:Text(listData[index],style: appThemeData.textTheme.headlineSmall,),
  //                   selectedColor: AppLightColor.elipsFill,
  //                   focusColor: AppLightColor.strokePositive,
  //
  //
  //                 ),
  //                 //divider
  //                 Padding(
  //                   padding: const EdgeInsets.all(10),
  //                   child: Container(
  //                     width: double.infinity,
  //                     height: 1,
  //                     color: AppLightColor.strokePositive,
  //                   ),
  //                 )
  //               ],
  //             );
  //           },
  //         ),
  //       )]
  //   ));
  //
  //
  //
  // }
  //
  // //location
  // openDialogLocation(context){
  //   showDialog(context: context, builder: (context)=>AlertDialog(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10.0))
  //       ),
  //       title: Text("Location",style: appThemeData.textTheme.headlineSmall,),
  //       backgroundColor: AppLightColor.backgoundPost,
  //       actions:[LocationScreen(),
  //         LocationCity(),
  //         Align(
  //             alignment: Alignment.center,
  //             child: CustomElevatedButton(onPressed: (){}, textColor: AppLightColor.withColor, color: AppLightColor.textBlueColor, title: "Save", height: 40.h, width: 120.w))
  //       ]
  //   ));
  //
  //
  //
  // }
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  // openDialogJobs(context){
  //   showDialog(context: context, builder: (context)=>AlertDialog(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10.0))
  //       ),
  //       title: Text("Jobs",style: appThemeData.textTheme.headlineSmall,),
  //       backgroundColor: AppLightColor.backgoundPost,
  //
  //       actions:[Container(
  //         height: 300.0, // Change as per your requirement
  //         width: 300.0, // Change as per your requirement
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: listJobs.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Column(
  //               children: [
  //                 ListTile(
  //                   leading: Icon(Icons.person_add,color: AppLightColor.fillButton,),
  //                   subtitle: Text("Please select the desired degree",style: appThemeData.textTheme.bodyMedium,),
  //                   onTap: (){
  //                     jobs=listJobs[index];
  //                     Get.back();
  //                     update();
  //                   },
  //                   title:Text(listJobs[index],style: appThemeData.textTheme.headlineSmall),
  //                   selectedColor: AppLightColor.elipsFill,
  //                   focusColor: AppLightColor.strokePositive,
  //
  //
  //                 ),
  //                 //divider
  //                 Padding(
  //                   padding: const EdgeInsets.all(10),
  //                   child: Container(
  //                     width: double.infinity,
  //                     height: 1,
  //                     color: AppLightColor.strokePositive,
  //                   ),
  //                 )
  //               ],
  //             );
  //           },
  //         ),
  //       )]
  //   ));
  //
  //
  //
  // }

  //openDialogLocation


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

                  //divider

                ],
              );
            },
          ),

        ),
      ),


      ],


    )

    );



  }
}


