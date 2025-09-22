import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_theme/app_theme.dart';
class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: Center(
                 child: Padding(
                   padding: const EdgeInsets.all(15),
                   child: DropdownSearch<String>(
                       popupProps: PopupProps.menu(
                         showSelectedItems: true,
                         showSearchBox: true,
                         searchFieldProps: TextFieldProps(
                           decoration: InputDecoration(
                             hintText: "search country",
                             helperStyle: appThemeData.textTheme.bodySmall,
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.grey),
                               borderRadius: BorderRadius.circular(20),

                             )

                           )
                         )
                       ),
                     items: ['england','poland','canada','iran'],
                     onChanged: print,
                     selectedItem: 'england',
                     dropdownDecoratorProps: DropDownDecoratorProps(
                       dropdownSearchDecoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.grey),
                           borderRadius: BorderRadius.circular(20),
                         ),
                         border: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.grey),
                           borderRadius: BorderRadius.circular(20),
                         )
                       )
                     ),
                   ),
                 ),
      ),
    );
  }
}





class LocationCity extends StatelessWidget {
  const LocationCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(
      height: 100.h,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: DropdownSearch<String>(
            popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                        hintText: "search country",
                        helperStyle: appThemeData.textTheme.bodySmall,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),

                        )

                    )
                )
            ),
            items: ['liverpol','amesterdam','vancover','tehran'],
            onChanged: print,
            selectedItem: 'liverpol',
            dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}

