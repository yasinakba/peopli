import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_route/route_names.dart';
import 'package:test_test_test/config/app_string/app_key_local_storage.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
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
  var locationText = "Unknown".obs;
  bool loading = false;

  /// For memory
  Future<void> getLocationFromGPS(AddMemoryController controller) async {
    loading = true;
    update();
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      controller.latitude = currentPosition.latitude;
      controller.longitude = currentPosition.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
        localeIdentifier: "en",
      );

      if (placemarks.isNotEmpty) {
        loading = false;
        final place = placemarks.first;
        controller.locationController.text =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        controller.update();
      }

      // Request permission
      var status = await Permission.location.request();

      if (status.isPermanentlyDenied) {
        loading = false;
        update();
        Get.snackbar(
          'Error',
          "❌ Permission permanently denied, opening settings...",
        );
        await openAppSettings();
        return;
      }
    } catch (e) {
      loading = false;
      update();
      Get.snackbar('Error', 'Unexpected Error $e');
    }
  }

  /// For set user location
  Future<void> lastKnownLocationFromGPS() async {
    loading = true;
    update();
    // 1. Request permission first
    var status = await Permission.location.request();
    if (!status.isGranted) {
      if (status.isPermanentlyDenied) {
        Get.snackbar('Error', "❌ Permission permanently denied, opening settings...");
        await openAppSettings();
      }
      return;
    }

    // 2. Get current location safely
    Position currentPosition;
    try {
      currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
      );
      setLocation(longitude: currentPosition.longitude, latitude: currentPosition.latitude);
    } catch (e) {
      Get.snackbar('Error',"Error getting GPS position: $e");
      return;
    } finally {
      loading = false;
      update();
    }
  }
  final dio = Dio();
  Future<void> setLocation({required longitude,required latitude,})async{
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(AppKeyLocalStorage.keyToken);

    final response = await dio.post('$baseURL/Api/set-location?token=$token&lng=$longitude&lat=$latitude',);
    print(response.data);
  }
  DateController dateController = Get.put( DateController());
  UploadController uploadController = Get.put( UploadController());
  void addMemory(faceId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   String? token =  preferences.getString(AppKeyLocalStorage.keyToken);
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
          'locationAddress':locationController.text,
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