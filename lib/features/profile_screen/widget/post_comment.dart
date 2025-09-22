import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/profile_screen/widget/tabbar_show.dart';
import 'package:test_test_test/features/profile_screen/widget/tabbar_show_comment.dart';

import '../../../config/app_colors/app_colors_light.dart';

class PostComment extends StatelessWidget {
  const PostComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        initialIndex: 0,
        child: Scaffold(
   backgroundColor: AppLightColor.withColor,
      body: Column(
        children: [
          Container(
            color: AppLightColor.backgoundPost,
            height: 25.h,
            width: 375.w,
            child: TabBar(
              unselectedLabelColor: AppLightColor.textBoldColor,
              labelColor: AppLightColor.withColor,
              indicator: BoxDecoration(

                border: Border.all(
                  color: AppLightColor.strokePositive
                ),
                color:AppLightColor.elipsFill,
                borderRadius: BorderRadius.circular(25),
              ),
              tabs: [
                Container(

                  width: 112.w,
                  height: 16.h,
                  child: Text("Post",textAlign: TextAlign.center,),
                ),

                Container(
                  width: 112.w,
                  height: 16.h,
                  child: Text("Commment",textAlign: TextAlign.center,),
                ),



              ],
            ),
          ),


          Expanded(
            child: Container(
              color: AppLightColor.withColor,
              child: TabBarView(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabbarShow(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarShowComment(),
                  )

                ],
              ),
            ),
          ),


        ],
      ),

    ));
  }
}
