import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';

class ListTileCreate extends StatelessWidget {
  final FaceEntity face;

  ListTileCreate({required this.face});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          Get.toNamed(NamedRoute.routePersonScreen);
        },

        leading: SizedBox(
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://api.peopli.ir/uploads/${face.avatar ?? ''}",
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            '${face.name??'null'} ${face.birthdate.toString()}',
            style: appThemeData.textTheme.labelMedium,
            maxLines: 2,
          ),
        ),

        subtitle: Column(
          children: [
            SizedBox(
              width: 180.w,
              child: Text(
                face.homeTown??'home Town address is null',
                style: appThemeData.textTheme.labelMedium,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 180.w,
              child: Text(
                face.job??'job is null',
                style: appThemeData.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
