import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';


class ListTileCreate extends StatelessWidget {
  const ListTileCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: (){
          Get.toNamed(NamedRoute.routePersonScreen);
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
