import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/create_account/controller/create_account_controller.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/feature_upload/upload_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../feature_location/controller/location_controller.dart';
import '../../feature_location/entity/city_entity.dart';
import '../../feature_location/entity/country_entity.dart';
import '../../search_screen/controller/search_bottom_controller.dart';
import '../widget/create_cancel_person.dart';
import '../widget/listTile_create.dart';
import 'package:flutter/foundation.dart';

class CreatePersonController extends GetxController {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController knowAsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  bool searchWithLocation = false;
  bool searchWithEducation = false;
  bool searchWithJob = false;
  List<FaceEntity> faceList = [];
  late final pagingFaceController = PagingController<int, dynamic>(
    getNextPageKey: (state) =>
    state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => searchFace(pageKey),
  );
  int selectedRadio = 0;
  int selectedLanguage = 0;
  XFile? pickedFile;
  String gender = '';
  DateController dateController = Get.put(DateController());

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => CreateAccountController());
    Get.lazyPut(() => LocationController());
    CreateAccountController.selectedCity = CityEntity();
    CreateAccountController.selectedCountry = CountryEntity();
    Future.delayed(Duration.zero, () {
      update();
    });
  }

  final dio = Dio();

  /// Simple POST request with error handling
  Future<void> addFace() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      if (nameController.text.isEmpty ||
          familyNameController.text.isEmpty ||
          knowAsController.text.isEmpty ||
          gender == '' ||
          Get
              .find<UploadController>()
              .selectedImage
              .value
              .isEmpty ||
          CreateAccountController.selectedCity.id == null ||
          CreateAccountController.selectedEducation.id == null ||
          CreateAccountController.selectedJob.id == null) {
        Get.snackbar(
          'Error',
          'Please fill in all required fields before submitting.',
        );
        return;
      }
      var date = dateController.selectedDate;
      final formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day
          .toString().padLeft(2, '0')}";

      final data = {
        'token': token.toString(),
        'name': nameController.text.trim(),
        'lastName': familyNameController.text.trim(),
        'knownFor': knowAsController.text.trim(),
        'gender': gender,
        'avatar': Get
            .find<UploadController>()
            .selectedImage
            .value,
        'hometownId': CreateAccountController.selectedCity.id,
        'educationId': CreateAccountController.selectedEducation.id,
        'jobId': CreateAccountController.selectedJob.id,
        'birthDate': formattedDate,
      };

      // ✅ Send POST request with token in headers
      final response = await dio.post(
        '$baseURL/Api/Faces/add',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType,),
      );

      // ✅ Handle response safely
      if (response.statusCode == 200) {
        nameController.clear();
        familyNameController.clear();
        knowAsController.clear();
        pickedFile = null;
        selectedRadio = -1;
        Get.back();
        update();
        Get.snackbar('Success', 'Face added successfully!');
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while adding face: $e");
      debugPrint(stacktrace.toString());
      Get.snackbar('Error', 'An unexpected error occurred.');
    }
  }

  int facePage = 1;

  Future<List<FaceEntity>> searchFace(pageKey) async {
    if (pageKey <= facePage) {
      try {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        if (CreateAccountController.selectedCity.id == null ||
            CreateAccountController.selectedEducation.id == null ||
            CreateAccountController.selectedJob.id == null) {
          Get.snackbar("Error", "⚠️ One or more required fields are null");
          return faceList;
        }

        final requestData = {
          'token': token,
          'page': pageKey,
          'take': 15,
          'filter': nameController.text,
        };
        final response = await dio.get(
          '$baseURL/Api/Faces',
          queryParameters: requestData,
          options: Options(
            contentType:
            Headers.formUrlEncodedContentType, // crucial for .NET backend
          ),
        );
        if (response.statusCode == 200) {
          facePage = response.data['data']['pageCount'];
          List<dynamic> data = response.data['data']['faces'];
          faceList.addAll(data.map((i) => FaceEntity.fromJson(i)));
          update();
          return faceList;
        }
        return faceList;
      } catch (e, stacktrace) {
        debugPrint(stacktrace.toString());
        return faceList;
      }
    }
    return [];
  }

  updateLanguage(int index) {
    selectedLanguage = index;
    update();
  }

  setSelectedRadio(int val) {
    if (val == 1) {
      gender = 'male';
    } else if (val == 0) {
      gender = 'female';
    }
    selectedRadio = val;
    update();
  }

  textStyleEn(int index) {
    return index == selectedLanguage
        ? appThemeData.textTheme.headlineSmall
        : appThemeData.textTheme.bodyLarge;
  }

  openDialogPerson(context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            title: GetBuilder<CreatePersonController>(builder: (logic) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Do you mean?",
                      style: appThemeData.textTheme.headlineSmall),
                  Text("${logic.faceList.length} Result",
                      style: appThemeData.textTheme.labelLarge),
                ],
              );
            }),
            backgroundColor: AppLightColor.backgoundPost,
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: AppLightColor.strokePositive,
                      width: 1,
                    ),
                    color: AppLightColor.withColor,
                  ),
                  height: 300.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: GetBuilder<CreatePersonController>(
                    builder: (controller) {
                      return PagingListener(
                        controller: controller.pagingFaceController,
                        builder: (context, state, fetchNextPage) =>
                            PagedListView<int, dynamic>(
                              state: state,
                              fetchNextPage: fetchNextPage,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              builderDelegate: PagedChildBuilderDelegate<
                                  dynamic>(
                                itemBuilder: (context, memory, index) {
                                  FaceEntity face = faceList[index];
                                  return ListTileCreate(face: face);
                                },
                                firstPageProgressIndicatorBuilder: (context) =>
                                    LoadingWidget(),
                                newPageProgressIndicatorBuilder: (context) =>
                                    LoadingWidget(),
                                noItemsFoundIndicatorBuilder: (context) =>
                                const Center(child: Text("No memories found.")),
                              ),
                            ),
                      );
                    },
                  ),
                ),
              ),
              CreateCancelPerson(),
            ],
          ),
    );
  }
}
