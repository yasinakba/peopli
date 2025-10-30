import 'package:get/get.dart';
import 'package:test_test_test/config/widgets/date_picker_widget.dart';

class DatePickerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(DateController());
  }

}