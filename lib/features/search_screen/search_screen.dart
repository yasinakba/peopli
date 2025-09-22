import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/search_screen/widget/search_list_tile.dart';
import 'package:test_test_test/features/search_screen/widget/text_field_search.dart';


import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/widgets/custom_radio_button.dart';
import 'controller/search_controller.dart';

class SearchScreen extends GetView<SearchButtomController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GetBuilder<SearchButtomController>(
            builder: (controller) => Column(
              children: [
                //divider
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppLightColor.cancelButtonFill,
                ),
                //search
                Container(
                  width: 375.w,
                  height: 285.h,
                  decoration: BoxDecoration(
                    color: AppLightColor.withColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppLightColor.cancelButtonFill,
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30,right: 30,left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomRadioButton(onPressed: ()=>controller.updateIndexButton(0), style: controller.textColorCustomButton(0), color: controller.colorCustomButton(0), title: 'Item', height: 22.h, width: 103.w),
                            SizedBox(width: 60.w,),
                            CustomRadioButton( onPressed:()=>controller.updateIndexButton(1), style: controller.textColorCustomButton(1), color:controller.colorCustomButton(1), title: 'Map', height: 22.h, width: 103.h),

                          ],
                        ),
                      ),
                      //row2
                      Padding(
                        padding: const EdgeInsets.only(top: 30,right: 30,left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomRadioButton(onPressed: ()=>controller.updateIndexButtonItem(0), style: controller.textColorCustomButtonItem(0), color: controller.colorCustomButtonItem(0), title: 'Newest', height: 22.h, width: 84.w),
                            CustomRadioButton( onPressed:()=>controller.updateIndexButtonItem(1), style: controller.textColorCustomButtonItem(1), color:controller.colorCustomButtonItem(1), title: 'Oldest', height: 22.h, width: 84.w),
                            CustomRadioButton( onPressed:()=>controller.updateIndexButtonItem(2), style: controller.textColorCustomButtonItem(2), color:controller.colorCustomButtonItem(2), title: 'Popular', height: 22.h, width: 84.w),

                          ],
                        ),
                      ),

                      //textfield
                      Padding(
                        padding: const EdgeInsets.only(top: 12,right: 8,left: 8,bottom: 8),
                        child: Column(
                          children: [
                            //name & family
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child:InkWell(
                                      onTap: (){},
                                      child: Image.asset(AppAssetsPng.iconNavbarTwo,color: AppLightColor.textBoldColor,),
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 33),
                                  child: TextFieldSearch(labelText: 'Name & Family'),
                                ),
                              ],
                            ),
                            //birth
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TextFieldSearch(labelText: 'Birth'),
                            ),
                            //palce
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TextFieldSearch(labelText: 'Place'),
                            ),
                            //jop
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TextFieldSearch(labelText: 'Jop'),
                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //searchListTile
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SearchListTile(),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}



