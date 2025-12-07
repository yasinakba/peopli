import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const  String baseImageURL = 'https://api.peopli.ir/uploads';
const String baseURL = 'https://api.peopli.ir';
var isUploading = false.obs;
void showDefaultDialog({required String message,required String status,required bool isSucceed}){
  Get.defaultDialog(title: message,onConfirm: () => Get.back(),titleStyle: TextStyle(color: isSucceed?Colors.green:Colors.red,fontSize: 25),middleTextStyle: TextStyle(fontSize: 25,color: Colors.black));
}


bool isConnected = false;
Future<bool> checkInternet()async{
  Connectivity().onConnectivityChanged.listen((status) {
    print(status);
    if(status == ConnectivityResult.wifi|| status == ConnectivityResult.mobile){
      isConnected = true;
    }else {
      showDefaultDialog(status: "Error",message: "Please Check the Internet",isSucceed: false);
      isConnected = false;
    }
  },);
    return isConnected;
}

