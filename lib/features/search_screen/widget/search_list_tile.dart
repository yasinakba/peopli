import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../controller/search_bottom_controller.dart';

class SearchListTile extends StatelessWidget {
  final SearchBottomController searchController = Get.put(
      SearchBottomController());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<SearchBottomController>(builder: (logic) {
      return Container(
          width: 295.w,
          height: 355.h,
          decoration: BoxDecoration(
              color: AppLightColor.withColor,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(width: 1.w, color: AppLightColor.strokeStar)),
          child: CustomScrollView(
            slivers: [
              SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                FaceEntity face = logic.faceList[index];
                if(logic.faceList.isEmpty){
                  return Center(child: Text('Does not exist',style: theme.textTheme.titleMedium,));
                }
                return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(NamedRoute.routePersonScreen);
                        },
                        leading: SizedBox(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage("https://api.peopli.ir/uploads/${face.avatar}"),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(

                            children: [
                              Text(face.name??'',
                                  style: appThemeData.textTheme.labelMedium),
                              Text(face.birthdate??'null', style: appThemeData.textTheme.labelMedium),
                            ],
                          ),
                        ),

                        subtitle: Column(
                          children: [
                            SizedBox(
                              width: 180.w,
                              child: Text(
                                face.homeTown??'null',
                                style: appThemeData.textTheme.labelMedium,
                                maxLines: 1,
                                textAlign: TextAlign.left,

                              ),
                            ),
                            SizedBox(
                              width: 180.w,
                              child: Text(face.job??'null',
                                  style: appThemeData.textTheme.labelMedium),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
               childCount: logic.faceList.length)),
            ],
          ));
    });
  }
}
