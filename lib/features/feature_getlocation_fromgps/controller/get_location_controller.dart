import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/add_memory/controller/add_memory_controller.dart';

class GetLocationController extends GetxController {
  var locationText = "Unknown".obs;

  Future<Position?> getUserLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return null;
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied");
      return null;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    Get.lazyPut(() => AddMemoryController(),);
    Get.find<AddMemoryController>().locationController.text = locationText.value;
    Get.find<AddMemoryController>().latitude = position.latitude;
    Get.find<AddMemoryController>().longitude = position.longitude;

    return position;
  }
}
