import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';

import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';


class ListViewProfile extends StatelessWidget {
  final FirstController postFirstScreen = Get.put(FirstController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<FirstController>(builder: (controller) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.faceList.length,
          itemBuilder: (BuildContext context, int index) {
           // FaceEntity face =  controller.faceList[index];
            return SizedBox(
              width: 80,
              height: 87,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(NamedRoute.routePersonScreen);
                    },
                    child: SizedBox(
                      width: 68,
                      height: 58,
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage(AppAssetsJpg.imagePerson),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text('mohamad', maxLines: 2,
                          style: appThemeData.textTheme.labelLarge!.copyWith(
                              color: theme.hoverColor),
                          textAlign: TextAlign.center),
                      Text('mahdavi', maxLines: 2,
                          style: appThemeData.textTheme.labelLarge,
                          textAlign: TextAlign.center),
                    ],
                  )
                ],
              ),
            );
          });
    });
  }
}
