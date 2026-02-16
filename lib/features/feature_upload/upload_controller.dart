import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:test_test_test/config/app_string/constant.dart';


class UploadController extends GetxController {
  bool loading = false;
  RxString selectedImage = 'usericon.png'.obs;
  final String uploadUrl = "$baseURL/uploader";

  XFile? pickedFile;

  Future<void> uploadImage() async {
    try {
      loading = true;
      update();

      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // optional compression
      );

      if (picked == null) {
        loading = false;
        update();
        return;
      }

      pickedFile = picked;
      final file = File(picked.path);

      // ✅ Check file size (max 5MB)
      final fileSizeInBytes = await file.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 5) {
        loading = false;
        update();
        Get.snackbar("Error", "File must be less than 5MB");
        return;
      }

      final request = http.MultipartRequest(
        "POST",
        Uri.parse(uploadUrl),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          "file", // must match backend IFormFile name
          file.path,
        ),
      );

      final streamedResponse =
      await request.send().timeout(const Duration(seconds: 30));

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        selectedImage.value = data['data'];
        Get.snackbar("Success", "Image uploaded successfully");
      } else {
        Get.snackbar(
          "Upload Failed",
          "Server error: ${response.statusCode}",
        );
      }
    } catch (e) {
      debugPrint("Upload Error: $e");
      Get.snackbar("Error", "Something went wrong. Try again.");
    } finally {
      loading = false;
      update();
    }
  }
}



