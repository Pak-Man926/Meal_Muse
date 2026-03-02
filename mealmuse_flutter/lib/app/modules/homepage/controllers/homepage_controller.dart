import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomepageController extends GetxController {
  //TODO: Implement HomepageController
  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    logger.i("HomepageController initialized");
  }

  @override
  void onReady() {
    super.onReady();
    logger.i("Homepage View is ready and visible");
  }

  @override
  void onClose() {
    super.onClose();
    logger.i("HomepageController is being disposed");
  }
}
