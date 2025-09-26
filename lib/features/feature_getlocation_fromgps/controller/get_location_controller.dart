import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/add_memory/controller/add_memory_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../feature_location/controller/location_controller.dart';

class GetLocationController extends GetxController {
  var locationText = "Unknown".obs;
  Future<void> getLocationFromGPS(AddMemoryController controller) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Check service
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("❌ Location services are disabled.");
        return;
      }

      // Request permission
      var status = await Permission.location.request();

      if (status.isDenied) {
        print("❌ Location permission denied by user.");
        return;
      }

      if (status.isPermanentlyDenied) {
        print("❌ Permission permanently denied, opening settings...");
        await openAppSettings();
        return;
      }

      // ✅ Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      controller.latitude = position.latitude;
      controller.longitude = position.longitude;

      // ✅ Convert to human-readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: "en", // force English
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        controller.locationController.text =
        "${place.street}, ${place.locality}, ${place
            .administrativeArea}, ${place.country}";
        Get.find<AddMemoryController>().update();
      }
    } else {
      await Geolocator.requestPermission();

    }
  }}