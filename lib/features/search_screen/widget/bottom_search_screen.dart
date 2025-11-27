import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/search_screen/controller/search_bottom_controller.dart';
import 'package:test_test_test/features/search_screen/widget/search_list_tile.dart';

import '../../../config/widgets/loading_widget.dart';
class BottomSearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<SearchBottomController>(
        builder: (controller) {
          bool notFound = controller.faceList.isEmpty && controller.displayNameController.text.isNotEmpty;
          return notFound? Container(
            margin: EdgeInsetsDirectional.only(top: 6.h),
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 20.w, vertical: 5.h,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(25),
            ),
            alignment: Alignment.center,
            child: Text(textAlign: TextAlign.center,
              'Not found',
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp),),
          ): controller.loadingSearch ? LoadingWidget() : SearchListTile();
        });
  }
}
