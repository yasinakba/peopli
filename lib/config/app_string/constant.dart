import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const  String baseImageURL = 'https://api.peopli.ir/uploads';
const String baseURL = 'https://api.peopli.ir';
var isUploading = false.obs;
void showDefaultDialog({required String message,required String status,required bool isSucceed}){
  Get.defaultDialog(content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 200.w,
        height: 100.h,
        child: Icon(Icons.error,color: isSucceed?Colors.green:Colors.red,size: 100),
      ),
      Text('Connection failed',style: TextStyle(color: isSucceed?Colors.grey:Colors.red,fontSize: 25),),
      Text(message,style: TextStyle(color: isSucceed?Colors.green:Colors.amber,fontSize: 25),)
    ],
  ),);
}


bool isConnected = false;
Future<bool> checkInternet()async{
  Connectivity().onConnectivityChanged.listen((status) {
    print(status);
    if(status == ConnectivityResult.wifi|| status == ConnectivityResult.mobile){
      isConnected = false;
    }else {
      isConnected = true;
    }
  },);
    return isConnected;
}

