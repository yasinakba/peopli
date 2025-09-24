import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/feature_location/entity/city_entity.dart';
import 'package:test_test_test/features/feature_location/entity/country_entity.dart';
class LocationController extends GetxController{


  final dio = Dio();
  List<CountryEntity> countryList = [];
  List<String> countryName = [];
  List<String> cityNames = [];
 static List<CityEntity> cityList = [];
  /// Simple GET request with error handling
  Future<void> getCountry() async {
    try {
      final response = await dio.get(
        "https://api.peopli.ir/Api/admin/Countries?page=1&take=15&sortBy=latest",
      );
      if(response.statusCode== 200){
      List<dynamic> data = response.data['data']['countries'];
      countryList.addAll(data.map((item) => CountryEntity.fromJson(item)));
      countryName.addAll(countryList.map((item)=> item.name??''));
      CreateAccountController.selectedCountry = countryList[0];
      update();
      // update(['country']);
      }
    } on DioException catch (e) {
      print("GET error: ${e.response?.statusCode} - ${e.message}");
    }
  }
  Future<void> getCity(countryId) async {
    LocationController.cityList.clear();
    try {
      final response = await dio.get(
        "https://api.peopli.ir/Api/admin/Countries/cities?page=1&take=15&sortBy=latest&countryId=${countryId}",
      );
      if(response.statusCode == 200){
      List<dynamic> data = response.data['data']['cities'];
      LocationController.cityList.addAll(data.map((item) => CityEntity.fromJson(item)));
      cityNames.addAll(cityList.map((item) =>item.name??''));
      CreateAccountController.selectedCity = cityList[0];
      update();
      }
    } on DioException catch (e) {
      print("GET error: ${e.response?.statusCode} - ${e.message}");
    }
  }



}