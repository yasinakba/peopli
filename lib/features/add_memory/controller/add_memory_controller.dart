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
  TextEditingController textController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  int selectedRadio = 0;

  String selectedRadioValue = 'Negative';
  XFile? pickedFile;
 GetLocationController getLocationController =  Get.put(GetLocationController());
  DateController dateController = Get.put( DateController());
  UploadController uploadController = Get.put( UploadController());
  final dio = Dio();
  void addMemory(faceId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   String? token =  preferences.getString('token');
    if (subjectController.text.isEmpty||textController.text.isEmpty||selectedRadioValue == '') {
      Get.snackbar('Error', 'Subject cannot be empty');
      return;
    }
    try {
      final response = await dio.post(
        '$baseURL/Api/Memories/add',
        data: {
          'token': '$token',
          'faceId': faceId,
          'title': subjectController.text,
          'text': textController.text,
          'type': selectedRadioValue,
          'lat': latitude, // fill if you have location data
          'lng': longitude,
          'media': uploadController.selectedImage.value, // make sure it's correctly encoded or uploaded
          'date': "${dateController.selectedDate.month}/${dateController.selectedDate.day}/${dateController.selectedDate.year}",
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        subjectController.clear();
        textController.clear();
        Get.toNamed(NamedRoute.routeHomeScreen);
        Get.snackbar('Success', 'Memory added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add memory');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Birth Date")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           dateController.pickDateTime(context);
          },
          child: Text(
            dateController.selectedDate == ''
                ? "Select Birth Date"
                : "Birth Date: ${dateController.selectedDate.day}/${dateController.selectedDate.month}/${dateController.selectedDate.year}",
          ),
        ),
      ),
    );
  }

  setSelectedRadio(int val) {
    if(val == 1){
      selectedRadioValue ='Neutral';
    }else if(val == 2){
     selectedRadioValue = 'Positive';
    }else if(val == 0){
      selectedRadioValue = 'Negative';
    }
    selectedRadio = val;
    update();
  }
}