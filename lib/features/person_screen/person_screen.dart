import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_jpg.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../home_screen/controller/home_controller.dart';
import '../person_add_memory/widget/more_add_memory.dart';
import 'controller/person_controller.dart';

class PersonScreen extends GetView<PersonController> {
  final FaceEntity face = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLightColor.withColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppLightColor.withColor,
        title: Text(
          face.name??'Name does not exist',
          style: appThemeData.textTheme.displayMedium,
        ),
        leading: IconButton(
          onPressed: () {
            Get.find<HomeController>().currentIndex=0;
            Get.find<HomeController>().update();
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: AppLightColor.rectangleBold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15, right: 10),
            child: CustomElevatedButton(
              onPressed: () {

              },
              textColor: AppLightColor.textBoldColor,
              color: AppLightColor.mapButton,
              title: 'map',
              height: 22.h,
              width: 75.w,
            ),
          ),
        ],
      ),
      body: GetBuilder<PersonController>(
        builder: (controller) => Column(
          children: [
            //divider
            Container(
              width: double.infinity,
              height: 1,
              color: AppLightColor.cancelButtonFill,
            ),
            //titel
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 60.w,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://api.peopli.ir/uploads/${face.avatar ??''}"),
                    ),
                  ),
                  SizedBox(
                    width: 125.w,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${face!.name ?? ''} ${face!.lastName}",
                            style: appThemeData.textTheme.headlineLarge,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            face!.country ?? 'your country null',
                            style: appThemeData.textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${face!.birthdate??'null'} - now",
                            style: appThemeData.textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            face!.homeTown??'your homeTown does not exist',
                            style: appThemeData.textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //AddMemmory
                  SizedBox(
                    width: 70.w,

                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 35.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: AppLightColor.fillRectangleType,
                              border: Border.all(
                                color: AppLightColor.strokePositive,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(NamedRoute.routeAddMemoryScreen,arguments: face);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  width: 30.w,
                                  height: 30.w,
                                  child: Image.asset(AppAssetsPng.iconPlus),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              width: 70.w,
                              child: Text(
                                "Add a memory",
                                style: appThemeData.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // MorePerson(),
            Container(
              width: double.infinity,
              height: 1,
              color: AppLightColor.cancelButtonFill,
            ),
          ],
        ),
      ),
    );
  }
}
