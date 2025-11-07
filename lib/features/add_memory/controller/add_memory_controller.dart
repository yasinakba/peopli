import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_route/route_names.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/features/feature_getlocation_fromgps/controller/get_location_controller.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';

class AddMemoryController extends GetxController {
  TextEditingController subjectController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  int selectedRadio = 0;
  String selectedRadioValue = 'Negative';
  XFile? pickedFile;
 // GetLocationController locationController =  Get.put(GetLocationController());
  DateController dateController = Get.put( DateController());
  @override
  void onInit() {
    super.onInit();

  }
  final dio = Dio();
  void addMemory(faceId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   String? token =  preferences.getString('token');
    if (subjectController.text.trim().isEmpty||typeController.text.isEmpty||selectedRadioValue == '') {
      Get.snackbar('Error', 'Subject cannot be empty');
      return;
    }
    try {
      final response = await dio.post(
        '$baseURL/Api/Memories/add',
        data: {
          'token':  token.toString(),
          'faceId': faceId,
          'title': selectedRadio,
          'text': subjectController.text.trim(),
          'type': typeController.text.trim(),
          'lat': '', // fill if you have location data
          'lng': '',
          'media': Get.find<UploadController>().selectedImage.value, // make sure it's correctly encoded or uploaded
          'date': "${date.month}/${date.day}/${date.year}",
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        subjectController.clear();
        typeController.clear();
        Get.toNamed(NamedRoute.routeHomeScreen);
        Get.snackbar('Success', 'Memory added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add memory');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }



 var date = Get.find<DateController>().selectedDate;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Birth Date")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.find<DateController>().pickDateTime(context);
          },
          child: Text(
            Get.find<DateController>().selectedDate == ''
                ? "Select Birth Date"
                : "Birth Date: ${date.day}/${date.month}/${date.year}",
          ),
        ),
      ),
    );
  }

  setSelectedRadio(int val) {
    if(val == 1){
      selectedRadioValue ='Neutral  ';
    }else if(val == 2){
     selectedRadioValue = 'Positive';
    }else if(val == 0){
      selectedRadioValue = 'Negative';
    }
    selectedRadio = val;
    update();
  }
}