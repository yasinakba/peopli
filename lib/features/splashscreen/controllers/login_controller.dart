import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
class LoginConteoller extends GetxController{


  @override
  void onInit() {

  }


  share() async {
     await Share.share("com.example.peopli");
  }

}