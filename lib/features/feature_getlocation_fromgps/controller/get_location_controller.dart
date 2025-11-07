import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/add_memory/controller/add_memory_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class GetLocationController extends GetxController {
  var locationText = "Unknown".obs;
  Future<void> getLocationFromGPS(AddMemoryController controller) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Check service
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error',"❌ Location services are disabled.");
        return;
      }

      // Request permission
      var status = await Permission.location.request();

      if (status.isDenied) {
        Get.snackbar('Error', "❌ Location permission denied by user.");
        return;
      }

      if (status.isPermanentlyDenied) {
        Get.snackbar('Error',"❌ Permission permanently denied, opening settings...");
        await openAppSettings();
        return;
      }

      // ✅ Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      controller.latitude = position.latitude;
      controller.longitude = position.longitude;

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
          localeIdentifier: "en",
        );

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          controller.locationController.text =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
          controller.update();
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to get address Please enter manual your address");
        controller.locationController.text = "Unknown";
      }
    } else {
      await Geolocator.requestPermission();

    }
  }
}