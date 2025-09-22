import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_icons/app_assets_jpg.dart';
import '../../../config/app_icons/app_assets_png.dart';
import '../../../config/app_theme/app_theme.dart';

class PostProfile extends StatelessWidget {
  const PostProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 345.w,
        decoration: BoxDecoration(
            color:AppLightColor.backgoundPost,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          children: [
            //famous
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
              child: InkWell(
                onTap: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    SizedBox(
                      width: 115.w,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 55.w,
                            height: 55.h,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage(AppAssetsJpg.imagePerson),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: Text("2.0")),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            //post
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10,bottom: 5),
                  child: SizedBox(
                    width: 44.w,
                    height: 44.h,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(AppAssetsJpg.userPost),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(

                    children: [
                      SizedBox(width: 130.w, child: Text("John Smith ",style: appThemeData.textTheme.labelMedium,textAlign: TextAlign.start,)),
                      SizedBox(width: 130.w,height: 15,child: Align( alignment: Alignment.bottomLeft,    child: Icon(Icons.circle,color: AppLightColor.negativeFill,size: 10,))),

                    ],
                  ),
                ),

              ],
            ),
            //Description
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
              child: SizedBox(

                  child: AutoSizeText('Your Power" each peaked within the top 10 in the US and UK. Eilish has received several accolades',maxLines: 3,style:appThemeData.textTheme.headlineLarge,textAlign: TextAlign.start ,)),
            ),
            //Location
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 20,bottom: 5,top: 5),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  AutoSizeText('Pais School, Versue Street, Paris',maxLines: 3,style:appThemeData.textTheme.bodySmall,textAlign: TextAlign.start ,)

                ],
              ),

            ),
            //imagepost
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5),
              child: SizedBox(
                  width: 293.w,
                  height: 141.h,
                  child: Image.asset(AppAssetsJpg.postImage,fit: BoxFit.cover,)),
            ),
            //Like && share
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //comment
                  Row(
                    children: [

                      InkWell(
                        onTap:(){} ,
                        child: SizedBox(width: 17.w,height: 17.h, child: Image.asset(AppAssetsPng.iconComment,color: AppLightColor.postNavbar,)),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text("123",style:appThemeData.textTheme.bodyMedium,),
                      ),

                    ],
                  ),
                  //heart
                  Row(
                    children: [

                      InkWell(
                        onTap:(){} ,
                        child: SizedBox(
                            width: 17.w,
                            height: 17.w,
                            child: Image.asset(AppAssetsPng.iconLHeart,color: AppLightColor.postNavbar,)),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text("123",style: appThemeData.textTheme.bodyMedium,),
                      ),

                    ],
                  ),
                  //share
                  Row(
                    children: [

                      InkWell(
                        onTap:(){} ,
                        child: SizedBox(width: 17.w,height: 17.h,  child: Image.asset(AppAssetsPng.iconShare,color: AppLightColor.postNavbar,)),
                      ),

                    ],
                  ),
                  //time
                  Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text("10:45",style: appThemeData.textTheme.bodyMedium,),
                      ),

                    ],
                  ),

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
