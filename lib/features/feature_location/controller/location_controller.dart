import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/feature_location/entity/city_entity.dart';
import 'package:test_test_test/features/feature_location/entity/country_entity.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';

import '../../add_memory/controller/add_memory_controller.dart';

class LocationController extends GetxController{
  var locationText = "Unknown".obs;
  bool loading = false;
  RxBool loadingForRegisterMemory = false.obs;

  /// For memory
  Future<void> getLocationForRegisterMemory(AddMemoryController controller) async {
    loadingForRegisterMemory.value = true;
    try {
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
        final place = placemarks.first;
        controller.locationController.text =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        controller.update();
      }

      // Request permission
      var status = await Permission.location.request();

      if (status.isPermanentlyDenied) {
        loadingForRegisterMemory.value = false;
        Get.snackbar(
          'Error',
          "❌ Permission permanently denied, opening settings...",
        );
        await openAppSettings();
        return;
      }
    } catch (e) {
      loadingForRegisterMemory.value = false;
      Get.snackbar('Error', 'Unexpected Error $e');
    }
  }

  /// For set user location
  final RxBool isGettingLocation = false.obs;

  Future<void> getLocation() async {
    try {
      isGettingLocation.value = true;

      // 1️⃣ Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Location Disabled', 'Please enable GPS service.');
        return;
      }

      // 2️⃣ Request permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Location permission is required.');
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Permission Permanently Denied',
          'Please enable location from settings.',
        );
        await Geolocator.openAppSettings();
        return;
      }

      // 3️⃣ Get current position with timeout
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).timeout(const Duration(seconds: 10));

      setLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );

    } catch (e) {

      // 4️⃣ Fallback to last known location if GPS fails
      Position? lastPosition = await Geolocator.getLastKnownPosition();

      if (lastPosition != null) {
        setLocation(
          latitude: lastPosition.latitude,
          longitude: lastPosition.longitude,
        );
      } else {
        Get.snackbar('Error', 'Unable to get location.');
      }

    } finally {
      isGettingLocation.value = false;
    }
  }

  final dio = Dio();
  Future<void> setLocation({required longitude,required latitude,})async{
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    final response = await dio.post('$baseURL/Api/set-location?token=$token&lng=$longitude&lat=$latitude',);
    if(response.statusCode == 200) {
      Get.find<FirstController>().pagingFaceController.refresh();
      Get.find<FirstController>().readMoreFace(1);
    }
  }
  List<CountryEntity> countryList = [];
  List<String> countryName = [];
  List<String> cityNames = [];
 static List<CityEntity> cityList = [];



  /// Simple GET request with error handling
  Future<void> getCountry() async {
    try {
      final response = await dio.get(
        "$baseURL/Api/admin/Countries?page=1&take=15&sortBy=latest",
      );
      if(response.statusCode== 200){
      List<dynamic> data = response.data['data']['countries'];
      countryList.addAll(data.map((item) => CountryEntity.fromJson(item)));
      countryName.addAll(countryList.map((item)=> item.name??''));
      CreateAccountController.selectedCountry = countryList[0];
      update();
      update(['country']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error","GET error: ${e.response?.statusCode} - ${e.message}");
    }
  }
  Future<void> getCity(countryId) async {
    loading = true;
    LocationController.cityList.clear();
    update();
    try {
      final response = await dio.get(
        "$baseURL/Api/admin/Countries/cities?page=1&take=15&sortBy=latest&countryId=${countryId}",
      );
      if(response.statusCode == 200){
      List<dynamic> data = response.data['data']['cities'];
      LocationController.cityList.addAll(data.map((item) => CityEntity.fromJson(item)));
      cityNames.addAll(cityList.map((item) =>item.name??''));
      CreateAccountController.selectedCity = cityList[0];
      loading = false;
      update(['city']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error","GET error: ${e.response?.statusCode} - ${e.message}");
    }
  }
}