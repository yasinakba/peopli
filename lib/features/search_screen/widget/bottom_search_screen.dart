import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/features/search_screen/controller/search_bottom_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../create_person/entity/face_entity.dart';

class BottomSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBottomController>(
      builder: (controller) {
        bool notFound =
            controller.faceList.isEmpty &&
            controller.displayNameController.text.isNotEmpty;

        return Container(
          margin: EdgeInsets.only(top: 6.h),
          width: 295.w,
          height: 300.h,
          decoration: BoxDecoration(
            color: AppLightColor.withColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(width: 1.w, color: AppLightColor.strokeStar),
          ),
          child:controller.loadingSearch? LoadingWidget(): notFound ? Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Does not exist😣',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                )
              :PagingListener<int, dynamic>(
            controller: controller.pagingFaceController,
            builder: (context, state, fetchNextPage) {
              return PagedListView<int, dynamic>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, item, index) {

                    if (controller.loadingSearch) {
                      return const Center(child: LoadingWidget());
                    }

                    // SAFE CAST
                    if (item == null || item is! FaceEntity) {
                      return SizedBox(); // or "Does not exist"
                    }

                    final face = item as FaceEntity;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            NamedRoute.routePersonScreen,
                            arguments: face,
                          );
                        },

                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            "$baseImageURL/${face.avatar}",
                          ),
                        ),

                        title: Flexible(
                          child: Text(
                            '${face.name ?? ''} ${face.birthdate.toString().substring(0,4) ?? ''}',
                            style: appThemeData.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              face.homeTown ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appThemeData.textTheme.labelMedium,
                            ),
                            Text(
                              face.job ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appThemeData.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )

        );
      },
    );
  }
}
