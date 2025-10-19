import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/features/first_screen/controller/first_controller.dart';

import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../create_person/entity/face_entity.dart';


class ListViewProfile extends StatelessWidget {
  final FirstController postFirstScreen = Get.put(FirstController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<FirstController>(builder: (controller) {
      return PagingListener(
        builder: (context, state, fetchNextPage) {
         return PagedListView(scrollDirection: Axis.horizontal,state: state, fetchNextPage: fetchNextPage, builderDelegate: PagedChildBuilderDelegate(
           firstPageProgressIndicatorBuilder: (context) =>
               Padding(
                 padding: EdgeInsets.all(10),
                 child: SpinKitFadingCube(
                   duration: Duration(seconds: 1),
                   itemBuilder: (BuildContext context, int index) {
                     return DecoratedBox(
                       decoration: BoxDecoration(
                         color: index.isEven ? Colors.green : Colors.blue,
                       ),
                     );
                   },
                 ),
               ),

           newPageProgressIndicatorBuilder: (context) =>
               Padding(
                 padding: EdgeInsets.all(10),
                 child: SpinKitFadingCube(
                   duration: Duration(seconds: 1),
                   itemBuilder: (BuildContext context, int index) {
                     return DecoratedBox(
                       decoration: BoxDecoration(
                         color: index.isEven ? Colors.green : Colors.blue,
                       ),
                     );
                   },
                 ),
               ),
           itemBuilder: (context, item, index) {
            FaceEntity face = controller.faceList[index];
            if(controller.faceList.length-1 <= index){
              return SizedBox(
                width: 80,
                height: 87,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(NamedRoute.routePersonScreen,arguments:face);
                      },
                      child: SizedBox(
                        width: 68,
                        height: 58,
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage("https://api.peopli.ir/uploads/${face.avatar}"),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(face.name??'null', maxLines: 2,
                            style: appThemeData.textTheme.labelLarge!.copyWith(
                                color: theme.hoverColor),
                            textAlign: TextAlign.center),
                        Text(face.lastName??'null', maxLines: 2,
                            style: appThemeData.textTheme.labelLarge,
                            textAlign: TextAlign.center),
                      ],
                    )
                  ],
                ),
              );
            }

            return SizedBox(
              width: 80,
              height: 87,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(NamedRoute.routePersonScreen,arguments:face);
                    },
                    child: SizedBox(
                      width: 68,
                      height: 58,
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage("https://api.peopli.ir/uploads/${face.avatar}"),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(face.name??'null', maxLines: 2,
                          style: appThemeData.textTheme.labelLarge!.copyWith(
                              color: theme.hoverColor),
                          textAlign: TextAlign.center),
                      Text(face.lastName??'null', maxLines: 2,
                          style: appThemeData.textTheme.labelLarge,
                          textAlign: TextAlign.center),
                    ],
                  )
                ],
              ),
            );
          },),);
        },
        controller: controller.pagingFaceController,
      );
    });
  }
}
