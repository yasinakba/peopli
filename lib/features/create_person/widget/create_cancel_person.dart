import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/create_person_controller.dart';
class CreateCancelPerson extends GetView<CreatePersonController> {
  const CreateCancelPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 10),
        child: GetBuilder<CreatePersonController>(builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
              Get.back();
            }, child: Text('Cancel',style: theme.textTheme.labelMedium!.copyWith(),)),
          ElevatedButton(
                onPressed: () {
                  controller.addFace();
            }, child: Text('Create',style: theme.textTheme.labelMedium!.copyWith(),)),
             ],
        ),)
    );
  }
}
