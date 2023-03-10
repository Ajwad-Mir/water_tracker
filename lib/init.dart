import 'package:get/get.dart';
import 'package:water_tracker/export.dart';

class appBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
