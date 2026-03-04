import 'package:get/get.dart';

import '../controllers/savedpage_controller.dart';

class SavedpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedpageController>(
      () => SavedpageController(),
    );
  }
}
