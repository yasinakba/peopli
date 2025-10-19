import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class AddMemoryController extends GetxController {
  final dateController = TextEditingController();
  final subjectController = TextEditingController();
  final typeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  int selectedRadio = 0;
  String selectedRadioValue = 'Negative';
  XFile? pickedFile;

  @override
  void onInit() {
    super.onInit();
  }
  final dio = Dio();

  void addMemory(faceId) async {
    // ✅ Step 1: Get token
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    if (token == '') {
      Get.snackbar('Error', 'Token is invalid');
      return;
    }

    // ✅ Step 2: Validate inputs
    if (faceId == null) {
      Get.snackbar('Error', 'Face ID is missing');
      return;
    }

    if (selectedRadioValue == '') {
      Get.snackbar('Error', 'Please select a title');
      return;
    }

    if (subjectController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Subject cannot be empty');
      return;
    }

    if (typeController.text.isEmpty) {
      Get.snackbar('Error', 'Type cannot be empty');
      return;
    }

    if (selectedDate == null) {
      Get.snackbar('Error', 'Please select a date');
      return;
    }

    try {
      final response = await dio.post(
        'https://api.peopli.ir/Api/Memories/add',
        data: {
          'token': token.toString(),
          'faceId': faceId,
          'title': selectedRadio,
          'text': subjectController.text.trim(),
          'type': typeController.text.trim(),
          'lat': '', // fill if you have location data
          'lng': '',
          'media': selectedImage.value, // make sure it's correctly encoded or uploaded
          'date': "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // ✅ Step 4: Handle response
      print(response.data);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Memory added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add memory');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  var isUploading = false.obs;

  RxString selectedImage = 'usericon.png'.obs;
  final String uploadUrl = "https://api.peopli.ir/uploader";

  Future<void> uploadImage() async {
    final picker = ImagePicker();

    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file == null) {
      print("No file selected");
      return;
    }
    pickedFile = file;
    File imageFile = File(file.path);

    // Create multipart request
    var request = http.MultipartRequest("POST", Uri.parse(uploadUrl));

    // "file" must match your IFormFile parameter name
    request.files.add(
      await http.MultipartFile.fromPath("file", imageFile.path),
    );

    // Send request
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var data = await json.decode(responseBody);
      selectedImage.value = data['data']; // for ex// ample
      update();
      final respStr = await response.stream.bytesToString();
      print("Upload success: $respStr");
    } else {
      print("Upload failed: ${response.statusCode}");
    }
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
      update();
      print("Selected birth date: $picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Birth Date")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            pickDateTime(context);
          },
          child: Text(
            selectedDate == null
                ? "Select Birth Date"
                : "Birth Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
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