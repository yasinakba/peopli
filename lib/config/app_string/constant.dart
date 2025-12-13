import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const  String baseImageURL = 'https://api.peopli.ir/uploads';
const String baseURL = 'https://api.peopli.ir';
var isUploading = false.obs;
void showDefaultDialog(){
  Get.defaultDialog(content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 200.w,
        height: 100.h,
        child: Icon(Icons.error,color: Colors.red.shade300,size: 100),
      ),
      Text('Connection failed',style: TextStyle(color: Colors.black12,fontSize: 25),),
      Text('Please check the internet',style: TextStyle(color: Colors.red.shade300,fontSize: 25),)
    ],
  ),);
}


bool isConnected = false;
Future<bool> checkInternet()async{
  Connectivity().onConnectivityChanged.listen((status) {
    print(status);
    if(status == ConnectivityResult.wifi|| status == ConnectivityResult.mobile){
      isConnected = false;
      showDefaultDialog();
    }else {
      isConnected = true;
    }
  },);
    return isConnected;
}

