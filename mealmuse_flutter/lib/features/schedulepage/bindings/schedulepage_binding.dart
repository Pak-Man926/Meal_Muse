import 'package:get/get.dart';

import '../controllers/schedulepage_controller.dart';

class SchedulepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulepageController>(
      () => SchedulepageController(),
    );
  }
}
