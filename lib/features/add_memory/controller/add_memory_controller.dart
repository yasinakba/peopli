import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMemoryController extends GetxController{
final dateController = TextEditingController();
final subjectController = TextEditingController();
final typeController = TextEditingController();
final locationController = TextEditingController();
 double latitude = 0.0;
 double longitude = 0.0;
int selectedRadio=0;
File? pickedFile;
  @override
  void onInit() {

  }
final dio = Dio();
  void addMemory()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
   String? token = preferences.getString('token');
    final response = dio.post('https://api.peopli.ir/Api/Memories/add',queryParameters: {
      'token':'Bearer $token',
      'faceId':'',
      'title':selectedRadio,
      'text':subjectController.text,
      'type':typeController.text,
      'lat':'',
      'lng':'',
      'media':pickedFile!.path,
      'date':"${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
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
setSelectedRadio(int val){

    selectedRadio=val;
    update();
}

uploadImage() async {
  final  picker = ImagePicker();
// Pick an image.
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  pickedFile=File(pickedImage!.path);
  update();
}





}