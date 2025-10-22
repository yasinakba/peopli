import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors/app_colors_light.dart';
import '../../../config/app_theme/app_theme.dart';
import '../controller/person_add_controller.dart';


class MorePerson extends GetView<PersonAddController> {
  const MorePerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonAddController>(builder: (controller) => Container(
      child: ExpansionTile(
        trailing: SizedBox(),

        backgroundColor: AppLightColor.withColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 57),
              child: Text("More...",style: appThemeData.textTheme.titleLarge,),
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //RatingBar
            children: [
              SizedBox(
                  width: 250.w,
                  // height: 100.h,
                  child:RatingBar.builder(
                    initialRating: controller.ratingNumber,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {

                      controller.ratingNumber=rating;
                      controller.update();
                      print(controller.ratingNumber);

                    },
                  )
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text("${controller.ratingNumber}",style: appThemeData.textTheme.displayMedium),
                    Text("Vote",style: appThemeData.textTheme.titleLarge),
                  ],
                ),
              )
            ],
          ),
          //has in born
          Padding(
            padding: const EdgeInsets.only(left: 40,top: 20),
            child: Row(
              children: [
                //Has BornIN
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text:TextSpan(
                        text: "Has born in :    ",style: appThemeData.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "(12/08/1991) , ",style: appThemeData.textTheme.bodyLarge
                          ) ,
                          TextSpan(
                              text: "paris , ",style: appThemeData.textTheme.bodySmall
                          ),
                          TextSpan(
                              text: "French",style: appThemeData.textTheme.bodySmall
                          ),
                        ]
                    ),

                  ),
                ),
              ],
            ),
          ),
          //Education
          Padding(
            padding: const EdgeInsets.only(left: 40,),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text:TextSpan(
                        text: "EduCation :      ",style: appThemeData.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "(1995) Diploma in Art , ",style: appThemeData.textTheme.bodyLarge
                          ) ,
                          TextSpan(
                              text: "Herman High , ",style: appThemeData.textTheme.bodySmall
                          ),
                          TextSpan(
                              text: "school. Paris ",style: appThemeData.textTheme.bodySmall
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Works
          Padding(
            padding: const EdgeInsets.only(left: 40,),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text:TextSpan(
                        text: "Works :             ",style: appThemeData.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "(2005-7) Mayor , ",style: appThemeData.textTheme.bodyLarge
                          ) ,
                          TextSpan(
                              text: "Municipality of Paris , ",style: appThemeData.textTheme.bodySmall
                          ),
                          TextSpan(
                              text: " France ",style: appThemeData.textTheme.bodySmall
                          ),
                        ]
                    ),

                  ),
                ),
              ],
            ),
          ),
          //Spouse
          Padding(
            padding: const EdgeInsets.only(left: 40,),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text:TextSpan(
                        text: "Spouse :          ",style: appThemeData.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "(2008-now) , ",style: appThemeData.textTheme.bodyLarge
                          ) ,
                          TextSpan(
                              text: "Martin Simpsons , ",style: appThemeData.textTheme.bodySmall
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Children
          Padding(
            padding: const EdgeInsets.only(left: 40,),
            child: Row(

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text:TextSpan(
                        text: "Children :         ",style: appThemeData.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "(2011-now) , ",style: appThemeData.textTheme.bodyLarge
                          ) ,
                          TextSpan(
                              text: "Edward Simpsons , ",style: appThemeData.textTheme.bodySmall
                          ),

                        ]
                    ),

                  ),
                ),

              ],
            ),
          ),
          //Lives
          Padding(
            padding: const EdgeInsets.only(left: 40,),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text:TextSpan(
                        text: "Lives :              ",style: appThemeData.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "(2011-now) , ",style: appThemeData.textTheme.bodyLarge
                          ) ,
                          TextSpan(
                              text: "Bond Pavilion , ",style: appThemeData.textTheme.bodySmall
                          ),
                          TextSpan(
                              text: "Mercury St , ",style: appThemeData.textTheme.bodySmall
                          ),
                          TextSpan(
                              text: "Paris , ",style: appThemeData.textTheme.bodySmall
                          ),
                          TextSpan(
                              text: "France , ",style: appThemeData.textTheme.bodySmall
                          ),

                        ]
                    ),

                  ),
                ),
              ],
            ),
          ),
          //Awards
          Padding(
            padding: const EdgeInsets.only(left: 40,),
            child: Row(

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text:TextSpan(
                        text: "Awards :          ",style: appThemeData.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "(2011-now) , ",style: appThemeData.textTheme.bodyLarge
                          ) ,
                          TextSpan(
                              text: "Edward Simpsons , ",style: appThemeData.textTheme.bodySmall
                          ),

                        ]
                    ),

                  ),
                ),

              ],
            ),
          ),
          //less&Edit
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                      onTap: (){
                        ExpansionTileController.of(context).collapse();
                        controller.update();
                      },
                      child: Text("Less",style: appThemeData.textTheme.titleLarge,)),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Edit",style: appThemeData.textTheme.titleLarge,),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
