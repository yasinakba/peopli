import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import 'comment_profile.dart';
import 'comment_profile2.dart';

class TabBarShowComment extends StatelessWidget {
  const TabBarShowComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: AppLightColor.withColor,
          body: Column(
            children: [
              Container(

                height: 30.h,
                width: 375.w,
                child: TabBar(
                  unselectedLabelColor: AppLightColor.elipsFill,

                  labelColor: AppLightColor.textBoldColor,
                  indicatorColor: AppLightColor.withColor,
                  tabs: [
                    Container(

                        width: 112.w,
                        height: 16.h,
                        child: Icon(Icons.list)
                    ),

                    Container(
                        width: 112.w,
                        height: 16.h,
                        child: Icon(Icons.border_all)
                    ),



                  ],
                ),
              ),


              Expanded(
                child: Container(
                  color: AppLightColor.withColor,
                  child: TabBarView(

                    children: [
                      Center(
                        child: ListView.builder(

                          itemCount: 3,
                          itemBuilder: (BuildContext context,int index){
                            return CommentProfile();
                          },),
                      ),
                      Center(
                          child: CommentProfile2()
                      ),


                    ],
                  ),
                ),
              ),




            ],
          ),

        ));
  }
}
