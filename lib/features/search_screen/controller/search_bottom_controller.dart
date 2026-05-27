import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test_test/config/app_string/app_key_local_storage.dart';
import 'package:test_test_test/config/app_string/app_key_string_ternationalization.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../create_account/controller/create_account_controller.dart';

class SearchBottomController extends GetxController {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController knowAsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  late final pagingFaceController = PagingController<int, FaceEntity>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => searchFace(pageKey),
  );
  int selected = 0;

  int selectedItem = 0;

  final dio = Dio();
  int facePage = 1;
  bool searchWithLocation = false;
  bool searchWithEducation = false;
  bool searchWithJob = false;
  bool loadingSearch = false;
  bool doesNotExist = false;
  List<FaceEntity> faceList = [];

  Future<List<FaceEntity>> searchFace(pageKey) async {
    if (pageKey == -1) {
      pageKey + 2;
      pagingFaceController.refresh();
    }
    faceList.clear();
    loadingSearch = true;
    update();
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString(AppKeyLocalStorage.keyToken);

      final requestData = {
        'sortBy': sortBy,
        'token': token,
        'page': pageKey,
        'take': 15,
        'filter': displayNameController.text,
        'hometownId': searchWithLocation
            ? CreateAccountController.selectedCity.id
            : null,
        'educationId': searchWithEducation
            ? CreateAccountController.selectedEducation.id
            : null,
        'jobId': searchWithJob ? CreateAccountController.selectedJob.id : null,
      };
      final response = await dio.get(
        '$baseURL/Api/Faces',
        queryParameters: requestData,
      );
      print(response.data);
      if (response.statusCode == 200) {
        facePage = response.data['data']['pageCount'];
        faceList.clear();
        List<dynamic> data = response.data['data']['faces'];
        faceList.addAll(data.map((i) => FaceEntity.fromJson(i)));
        loadingSearch = false;
        return faceList;
      }
      loadingSearch = false;
      return faceList;
    } catch (e, stacktrace) {
      loadingSearch = false;
      return [];
    }
  }

  updateIndexButton(index) {
    selected = index;
    update();
  }

  String sortBy = '';

  updateIndexButtonItem(index) {
    index == 1
        ? sortBy == AppKeyLocalization.label4
        : index == 2
        ? sortBy == AppKeyLocalization.label5
        : index == 0
        ? sortBy == AppKeyLocalization.label2
        : index;
    selectedItem = index;
    update();
  }

  Color colorCustomButton(int index) {
    return index == selected
        ? AppLightColor.elipsFill
        : AppLightColor.withColor;
  }

  Color colorCustomButtonItem(int index) {
    return index == selectedItem
        ? AppLightColor.elipsFill
        : AppLightColor.withColor;
  }

  textColorCustomButton(int index) {
    return index == selected
        ? appThemeData.textTheme.labelSmall
        : appThemeData.textTheme.labelLarge;
  }

  //2
  textColorCustomButtonItem(int index) {
    return index == selectedItem
        ? appThemeData.textTheme.labelSmall
        : appThemeData.textTheme.labelLarge;
  }
}
