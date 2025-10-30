import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:test_test_test/config/app_string/constant.dart';


class UploadController extends GetxController{
  RxString selectedImage = 'usericon.png'.obs;
  final String uploadUrl = "$baseURL/uploader";
  XFile? pickedFile;
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
      var data = await jsonDecode(responseBody);
      selectedImage.value = data['data']; // for ex// ample
      update();
    } else {
      Get.snackbar("Error","Upload failed: ${response.statusCode}");
    }
  }
}


