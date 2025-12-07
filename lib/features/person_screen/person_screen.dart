import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:rate/rate.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/cross_fade_widget_global.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../edit_person/controller/edit_person_controller.dart';
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
          face.name ?? 'Name does not exist',
          style: appThemeData.textTheme.displayMedium,
        ),
        leading: IconButton(
          onPressed: () {
            Get.toNamed(NamedRoute.routeHomeScreen);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: AppLightColor.rectangleBold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15, right: 10),
            child: CustomElevatedButton(
              onPressed: () {},
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
        builder: (controller) => CrossFadeWidgetGlobal(
          firstWidget: FirstWidget(face: face, controller: controller),
          secondWidget: SecondWidget(face: face, controller: controller),
          isToggled: controller.isToggled,
        ),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  final FaceEntity face;
  final PersonController controller;

  FirstWidget({required this.face, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          color: AppLightColor.cancelButtonFill,
        ),
        //title
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 60.h,
                width: 60.w,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "$baseImageURL/${face.avatar ?? ''}",
                  ),
                ),
              ),
              SizedBox(
                width: 125.w,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "${face.name ?? ''} ${face.lastName}",
                        style: appThemeData.textTheme.headlineLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        face.country ?? 'your country null',
                        style: appThemeData.textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "${face.birthdate?.substring(0,4) ?? 'null'} - now",
                        style: appThemeData.textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        face.homeTown ?? 'your homeTown does not exist',
                        style: appThemeData.textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              //AddMemory
              Container(
                width: 70.w,
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: AppLightColor.fillRectangleType,
                        border: Border.all(color: AppLightColor.strokePositive),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            NamedRoute.routeAddMemoryScreen,
                            arguments: face,
                          );
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
              IconButton(
                onPressed: () {
                  controller.isToggled = !controller.isToggled;
                  controller.update();
                },
                icon: Icon(
                  controller.isToggled
                      ? IconsaxPlusBold.arrow_circle_up
                      : IconsaxPlusBold.arrow_circle_down,
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
    );
  }
}

class SecondWidget extends StatelessWidget {
  final FaceEntity face;
  final PersonController controller;

  SecondWidget({required this.face, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FirstWidget(face: face, controller: controller),
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            width: 360.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Rate(
                  iconSize: 40,
                  color: Colors.yellow.shade700,
                  allowHalf: true,
                  allowClear: true,
                  initialValue: 3.5,
                  readOnly: false,
                  onChange: (value) {
                    controller.ratingNumber = value;
                    controller.update();
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => controller.voteFace(face.id),
                  child: Container(
                    alignment: Alignment.center,
                    width: 50.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.indigoAccent,
                    ),
                    child: Text(
                      'vote⭐',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.center,
          width: 250.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Has born in: ', style: customStyle),
                  Text('Education: ', style: customStyle),
                  Text('Works: ', style: customStyle),
                  Text('Lives: ', style: customStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(face.birthdate.toString(), style: customStyle2),
                  Text(face.education ?? '', style: customStyle2),
                  Text(face.job ?? '', style: customStyle2),
                  Text(face.homeTown ?? '', style: customStyle2),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(NamedRoute.routePersonEditScreen, arguments: face);
            Get.lazyPut(() => EditPersonController());
            Get.find<EditPersonController>().fill();
          },
          child: Container(
            margin: EdgeInsetsDirectional.all(6.h),
            alignment: Alignment.center,
            width: 50.w,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.indigoAccent,
            ),
            child: Text(
              'Edit 🧑️',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

TextStyle customStyle = TextStyle(
  color: Colors.black54,
  fontSize: 15,
  fontWeight: FontWeight.w900,
);
TextStyle customStyle2 = TextStyle(
  color: Colors.indigo,
  fontSize: 12,
  fontWeight: FontWeight.w900,
);
