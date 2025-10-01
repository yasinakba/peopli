import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../controller/search_bottom_controller.dart';

class SearchListTile extends StatelessWidget {
  final SearchBottomController searchController = Get.put(SearchBottomController());

  @override
  Widget build(BuildContext context) {
    return Container(

        width: 295.w,
        height: 355.h,
        decoration: BoxDecoration(
          color: AppLightColor.withColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(width: 1.w, color: AppLightColor.strokeStar)),
        child: ListView.builder(
          controller: searchController.scrollController,
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Get.toNamed(NamedRoute.routePersonScreen);
                },
                leading: SizedBox(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppAssetsJpg.listTileImage),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(

                      children: [
                        Text('Mohamad Mahdavi ',
                            style: appThemeData.textTheme.labelMedium),
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
          },
        ));
  }
}
