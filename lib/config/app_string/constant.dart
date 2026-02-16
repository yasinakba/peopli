import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const  String baseImageURL = 'https://api.peopli.ir/uploads';
const String baseURL = 'https://api.peopli.ir';
var isUploading = false.obs;
void checkInternetDialog({required VoidCallback onConfirm})async{
  Connectivity().onConnectivityChanged.listen((result) {
    if (result == ConnectivityResult.none) {
      Get.defaultDialog(
        onCancel: () {
          Get.back();
        },
        textCancel: 'cancel',
        textConfirm: 'retry',
        onConfirm: onConfirm,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200.w,
              height: 100.h,
              child: Icon(Icons.error,color: Colors.red.shade300,size: 100),
            ),
            Text('Connection failed',style: TextStyle(color: Colors.black,fontSize: 25),),
            Text('Please check the internet',style: TextStyle(color: Colors.red.shade300,fontSize: 25),)
          ],
        ),);
    } else {
      Get.back();
    }
  });
}