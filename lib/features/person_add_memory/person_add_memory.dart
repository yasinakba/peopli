import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_test_test/features/person_add_memory/widget/memory.dart';
import '../../config/app_colors/app_colors_light.dart';
import '../../config/app_icons/app_assets_jpg.dart';
import '../../config/app_icons/app_assets_png.dart';
import '../../config/app_route/route_names.dart';
import '../../config/app_theme/app_theme.dart';
import '../../config/widgets/customButton.dart';
import '../person_screen/controller/person_controller.dart';
import '../person_screen/widget/more_person.dart';
class PersonAddScreen extends GetView<PersonController> {
  const PersonAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLightColor.withColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppLightColor.withColor,
        title: Text("Sofia J west",style: appThemeData.textTheme.displayMedium,),
        leading:IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back_ios_new),color: AppLightColor.rectangleBold,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15, right: 10),
            child: CustomElevatedButton(onPressed: (){},
                textColor: AppLightColor.textBoldColor,
                color: AppLightColor.mapButton,
                title: 'map',
                height: 22.h,
                width: 75.w),
          ),
        ],
      ),
      body: ListView(
        children: [
          GetBuilder<PersonController>(builder: (controller) => Column(
            children: [
              //divider
              Container(
                width: double.infinity,
                height: 1,
                color:AppLightColor.cancelButtonFill,
              ),
              //titel
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 60.h,
                      width: 60.w,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(AppAssetsJpg.imagePerson),
                      ),
                    ),
                    SizedBox(
                      width: 125.w,
                      child: Column(

                        children: [

                          SizedBox(width: double.infinity,  child: Text("Sofia J. West",style: appThemeData.textTheme.headlineLarge,textAlign: TextAlign.start,)),
                          SizedBox(width: double.infinity, child: Text("wise president of France",style: appThemeData.textTheme.bodyLarge,textAlign: TextAlign.start,)),
                          SizedBox(width: double.infinity, child: Text("1975 - now",style: appThemeData.textTheme.bodyLarge,textAlign: TextAlign.start,)),
                          SizedBox(width: double.infinity, child: Text("Avenue 13, Bond Pavilion ...",style: appThemeData.textTheme.bodyLarge,textAlign: TextAlign.start,maxLines: 1,)),

                        ],
                      ),
                    ),
                    //AddMemmory
                    SizedBox(
                      width: 70.w,

                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(

                                width: 35.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                    color: AppLightColor.fillRectangleType,
                                    border: Border.all(color: AppLightColor.strokePositive),
                                    borderRadius: BorderRadius.all(Radius.circular(100))
                                ),
                                child: InkWell(
                                    onTap: (){
                                      Get.toNamed(NamedRoute.routeAddMemoryScreen);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                          width: 30.w,
                                          height: 30.w,
                                          child: Image.asset(AppAssetsPng.iconPlus)),
                                    )
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: SizedBox(
                                  width: 70.w,

                                  child: Text("Add a memory",style: appThemeData.textTheme.bodyLarge,)),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //readMore

              MorePerson(),
              Container(
                width: double.infinity,
                height: 1,
                color:AppLightColor.cancelButtonFill,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: PostMemory(),
              )
            ],
          ),),
        ],
      ),
    );
  }
}
