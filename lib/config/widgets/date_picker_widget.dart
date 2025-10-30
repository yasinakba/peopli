import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController{
  DateTime selectedDate = DateTime.now();
  void pickDateTime(context) async {
    DateTime now = DateTime.now(); // default: 18 years ago
    DateTime firstDate = DateTime(1900); // earliest selectable year
    DateTime lastDate = now; // latest selectable date: today

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: "Select your birth date",
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
      // return picked.toString();
    }
    // return '';
  }
}
