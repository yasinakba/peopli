import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMemoryController extends GetxController{

int selectedRadio=0;
File? pickedFile;
  @override
  void onInit() {

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