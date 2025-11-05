import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
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
         return PagedListView(
           scrollDirection: Axis.horizontal,state: state, fetchNextPage: fetchNextPage, builderDelegate: PagedChildBuilderDelegate(
           firstPageProgressIndicatorBuilder: (context) =>
               LoadingWidget(),
           newPageProgressIndicatorBuilder: (context) =>
               LoadingWidget(),
           itemBuilder: (context, item, index) {
            if(index < controller.faceList.length){
            FaceEntity face = controller.faceList[index];
              return SizedBox(
                width: 80,
                height: 87,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {Get.toNamed(NamedRoute.routePersonScreen,arguments:face);},
                      child: SizedBox(
                        width: 68,
                        height: 58,
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage("$baseImageURL/${face.avatar}"),
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
            return Container();
          },),);
        },
        controller: controller.pagingFaceController,
      );
    });
  }
}
