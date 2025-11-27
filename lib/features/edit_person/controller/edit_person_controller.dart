import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_route/route_names.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../../config/widgets/loading_widget.dart';
import '../../create_account/controller/create_account_controller.dart';
import '../../create_person/widget/create_cancel_person.dart';
import '../../create_person/widget/listTile_create.dart';
import '../../feature_upload/upload_controller.dart';

class EditPersonController extends GetxController {
  FaceEntity face = Get.arguments;
  int selectedRadio = 0;
  int selectedLanguage = 0;
  File? pickedFile;
  String education = "";
  String jobs = "";
  String gender = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.lazyPut(() => CreateAccountController());
    Get.lazyPut(() => UploadController());
    Get.lazyPut(() => DateController());

  }

  void fill()async{
    nameController.text = face.name ?? '';
    familyNameController.text = face.lastName ?? '';
    displayNameController.text = '${face.name}${face.lastName}';
    knowAsController.text = face.knownFor ?? '';
    locationController.text = face.homeTown ?? '';
    dateTimeController.text = face.birthdate ?? '';

  }
  TextEditingController displayNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController knowAsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  CreateAccountController createAccountController = Get.put(
    CreateAccountController(),
  );
  UploadController uploadController = Get.put(UploadController());
  DateController dateController = Get.put(DateController());
  late final pagingFaceController = PagingController<int, dynamic>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => searchFace(pageKey),
  );
  final Dio dio = Dio();

  Future<void> editFace(id) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      if (nameController.text.isEmpty ||
          familyNameController.text.isEmpty ||
          knowAsController.text.isEmpty ||
          gender == '' ||
          Get.find<UploadController>().selectedImage.value.isEmpty ||
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
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      final data = {
        'token': token.toString(),
        'name': nameController.text,
        'lastName': familyNameController.text,
        'knownFor': knowAsController.text,
        'gender': gender,
        'avatar': uploadController.selectedImage.value,
        'hometownId': CreateAccountController.selectedCity.id,
        'educationId': CreateAccountController.selectedEducation.id,
        'jobId': CreateAccountController.selectedJob.id,
        'birthDate': formattedDate,
        'faceId':id,
      };

      // ✅ Send POST request with token in headers
      final response = await dio.post(
        '$baseURL/Api/Faces/edit',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      // ✅ Handle response safely
      if (response.statusCode == 200) {
        nameController.clear();
        familyNameController.clear();
        knowAsController.clear();
        uploadController.pickedFile = null;
        selectedRadio = -1;
        Get.toNamed(
          NamedRoute.routePersonScreen,
          arguments: FaceEntity.fromJson(response.data['data']),
        );
        update();
        Get.snackbar('Success', 'Face edited successfully!');
      }
    } catch (e, stacktrace) {
      debugPrint("🔥 Exception while adding face: $e");
      debugPrint(stacktrace.toString());
      Get.snackbar('Error', 'An unexpected error occurred.');
    }
  }

  int facePage = 2;
  List<FaceEntity> faceList = [];

  Future<List<FaceEntity>> searchFace(pageKey) async {
    if (pageKey < facePage) {
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
        return [];
      }
    }
    return [];
  }

  updateLanguage(int index) {
    selectedLanguage = index;
    update();
  }

  setSelectedRadio(int val) {
    selectedRadio = val;
    val == 1 ? gender = 'male' : gender = 'female';
    update();
  }

  textStyleEn(int index) {
    return index == selectedLanguage
        ? appThemeData.textTheme.headlineSmall
        : appThemeData.textTheme.bodyLarge;
  }

  openDialogPerson(context) {
    ThemeData theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: GetBuilder<EditPersonController>(
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Do you mean?",
                  style: appThemeData.textTheme.headlineSmall,
                ),
                Text(
                  "${logic.faceList.length} Result",
                  style: appThemeData.textTheme.labelLarge,
                ),
              ],
            );
          },
        ),
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
              child: GetBuilder<EditPersonController>(
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
                          builderDelegate: PagedChildBuilderDelegate<dynamic>(
                            itemBuilder: (context, memory, index) {
                              if (faceList.isNotEmpty) {
                                return ListTileCreate(face: memory);
                              }
                              return Container();
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
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 20,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel',
                    style: theme.textTheme.labelMedium!.copyWith(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => editFace(face.id),
                  child: Text(
                    'Edit',
                    style: theme.textTheme.labelMedium!.copyWith(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
