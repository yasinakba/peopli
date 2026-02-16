import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  late StreamSubscription<List<ConnectivityResult>> _subscription;


  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {

      final hasConnection =
      !results.contains(ConnectivityResult.none);
      if (!hasConnection) {
        isConnected.value = false;

        if (!(Get.isDialogOpen ?? false)) {
          Get.dialog(
            const AlertDialog(
              title: Text("No Internet"),
              content: Text("Please check your connection."),
            ),
            barrierDismissible: false,
          );
        }
      } else {
        isConnected.value = true;

        if (Get.isDialogOpen ?? false) {
          Get.back(); // close dialog safely
        }
      }
    });

  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
