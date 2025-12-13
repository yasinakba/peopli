import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: 'Title',
          titleStyle: TextStyle(fontSize: 18),
          middleText: 'Middle Text',
          middleTextStyle: TextStyle(fontSize: 16),
          backgroundColor: Colors.blueGrey[100],
          radius: 15,
          textCancel: 'Cancel',
          cancelTextColor: Colors.red,
          onCancel: () {},
          textConfirm: 'Confirm',
          confirmTextColor: Colors.white,
          onConfirm: () {},
          buttonColor: Colors.green,
          barrierDismissible: false, // for blur with click on everywhere
          actions: [
            Icon(Icons.tab)
          ],  
        );
      },
    );
  }
}
