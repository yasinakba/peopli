import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/config/widgets/loading_widget.dart';
import 'package:test_test_test/config/widgets/not_found_widget.dart';
import 'package:test_test_test/features/person_screen/person_screen.dart';
import 'package:test_test_test/features/search_screen/controller/search_bottom_controller.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_route/route_names.dart';
import '../../../config/app_theme/app_theme.dart';
import '../../create_person/entity/face_entity.dart';
import '../../person_screen/controller/person_controller.dart';

class BottomSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBottomController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(top: 6.h),
          width: 295.w,
          height: 300.h,
          decoration: BoxDecoration(
            color: AppLightColor.withColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(width: 1.w, color: AppLightColor.strokeStar),
          ),
          child:   PagingListener<int, FaceEntity>(
                  controller: controller.pagingFaceController,
                  builder: (context, state, fetchNextPage) {
                    return PagedListView<int, FaceEntity>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<FaceEntity>(
                        itemBuilder: (context,FaceEntity item, index) {
                          // SAFE CAST

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                Get.find<PersonController>().id == item.id;
                                Get.find<PersonController>().readMoreMemories(1);
                                Get.to(()=> PersonScreen(), arguments: item);
                              },

                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "$baseImageURL/${item.avatar??'noavatar.png'}",
                                ),
                              ),

                              title: Text(
                                '${item.name ?? ''} ${item.birthdate.toString().substring(0, 4) ?? ''}',
                                style: appThemeData.textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),

                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.homeTown ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: appThemeData.textTheme.labelMedium,
                                  ),
                                  Text(
                                    item.job ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: appThemeData.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) => LoadingWidget(),
                        newPageProgressIndicatorBuilder: (context) => LoadingWidget(),
                        noItemsFoundIndicatorBuilder: (context) =>NotFoundWidget(),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
