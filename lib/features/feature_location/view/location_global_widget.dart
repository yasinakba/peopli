import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/app_theme/app_theme.dart';
import '../controller/location_controller.dart';

class CountryDropdown extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());
  final String selected;
  CountryDropdown({this.selected = '--'});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      id: 'country',
      initState: (state) {},
      builder: (controller) {
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
                      ),
                    ),
                  ),
                ),
                items: controller.countryName,
                onChanged: print,
                selectedItem: selected,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CityDropDown extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());
  final String selected;
  CityDropDown({this.selected = '--'});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      id: 'city',
      builder: (controller) {
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
                      ),
                    ),
                  ),
                ),
                items: controller.cityNames,
                onChanged: print,
                selectedItem: selected,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
