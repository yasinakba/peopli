import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_test_test/features/first_screen/widget/list_view_profile.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';

import '../../config/app_colors/app_colors_light.dart';


class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [

            //divider
            Container(
              width: double.infinity,
              height: 1,
              color: AppLightColor.cancelButtonFill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 100.h,
                child: ListViewProfile(),
              ),
            ),
            //divider
            Container(
              width: double.infinity,
              height: 1,
              color: AppLightColor.cancelButtonFill,
            ),



            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 4,
                itemBuilder:(context, index) {

                return  Padding(
                  padding:  EdgeInsets.only(top: 10,right: 10,left: 10,bottom: index==3?60:10),
                  child: PostFirstScreen(),
                );

                },


      ),
            ),
          ],
        )
    ,
    );
  }
}
