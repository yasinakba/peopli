import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/add_memory/controller/add_memory_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../config/app_string/constant.dart';

class GetLocationController extends GetxController {
  var locationText = "Unknown".obs;
  bool loading = false;
  
  @override
  void onInit() {
    super.onInit();
    checkInternet();
  }

  Future<void> getLocationFromGPS(AddMemoryController controller) async {
    loading = true;
    update();
    try{
    Position currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
   controller.latitude = currentPosition.latitude;
   controller.longitude = currentPosition.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentPosition.latitude,
      currentPosition.longitude,
      localeIdentifier: "en",
    );

    if (placemarks.isNotEmpty) {
      loading = false;
      final place = placemarks.first;
      controller.locationController.text = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      controller.update();
    }

      // Request permission
      var status = await Permission.location.request();

      if (status.isPermanentlyDenied) {
        loading = false;
        update();
        Get.snackbar('Error',"❌ Permission permanently denied, opening settings...");
        await openAppSettings();
        return;
      }


    }catch(e){
      loading = false;
      update();
      Get.snackbar('Error', 'Unexpected Error $e');
    }
  }
}