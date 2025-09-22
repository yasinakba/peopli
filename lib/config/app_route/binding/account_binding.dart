import 'package:get/get.dart';

import '../../../features/create_account/controller/create_account_controller.dart';

class AccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateAccountController());
  }

}