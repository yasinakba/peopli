import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/search_screen/controller/search_bottom_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../create_person/entity/face_entity.dart';
class BottomSearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return  GetBuilder<SearchBottomController>(
        builder: (controller) {
          bool notFound = controller.faceList.isEmpty && controller.displayNameController.text.isNotEmpty;

          return  Container(
              margin: EdgeInsets.only(top: 6.h),
              width: 295.w,
              height: 300.h,
              decoration: BoxDecoration(
                  color: AppLightColor.withColor,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(width: 1.w, color: AppLightColor.strokeStar)),
              child:notFound? Center(
                child: Text(textAlign: TextAlign.center,
                  'Does not exist😣',
                  style: TextStyle(color: Colors.purpleAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp),),
              ): CustomScrollView(
                slivers: [
                  SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                    FaceEntity face = controller.faceList[index];
                    if(controller.faceList.isEmpty){
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
                            backgroundImage: NetworkImage("$baseImageURL/${face.avatar}"),
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
                      childCount: controller.faceList.length)),
                ],
              ));
        });
  }
}
