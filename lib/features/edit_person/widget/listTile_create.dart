import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/person_screen/controller/person_controller.dart';

import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_theme/app_theme.dart';


class ListTileCreate extends StatelessWidget {
  FaceEntity face;
  ListTileCreate({required this.face});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: (){
          Get.find<PersonController>().id == face.id;
          Get.find<PersonController>().readMoreMemories(1);
          Get.to(()=>PersonController(),arguments: face);
        },

        leading: SizedBox(
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AppAssetsJpg.listTileCreateImage),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(

            children: [

              Text('Mohamad Mahdavi ',
                  style: appThemeData.textTheme.labelMedium,maxLines: 2,),
              Text('1992', style: appThemeData.textTheme.labelMedium),
            ],
          ),
        ),

        subtitle: Column(
          children: [
            SizedBox(
              width: 180.w,
              child: Text(
                "NajafiStreet,Kermanshah,iran",
                style: appThemeData.textTheme.labelMedium,
                maxLines: 1,
                textAlign: TextAlign.left,

              ),
            ),
            SizedBox(
              width: 180.w,

              child: Text("Mobile programmer",
                  style: appThemeData.textTheme.labelMedium),
            ),
          ],
        ),
      ),
    );
  }
}
