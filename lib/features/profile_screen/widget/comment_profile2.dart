import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../config/app_icons/app_assets_jpg.dart';
class CommentProfile2 extends StatelessWidget {
  const CommentProfile2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: MasonryGridView.builder(
          itemCount: 7,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(8),
            child: Stack(
              children: [
                Container(
                  child:ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image.asset('assets/images/jpg/image${index +1}.jpg')),
                ),
                Positioned(
                  top: 40,
                  left: 45,
                  child: Container(
                    width: 50.w,
                      height: 50.h,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(AppAssetsJpg.imagePerson)),),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
