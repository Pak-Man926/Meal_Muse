import 'package:get/get.dart';
import 'package:logger/logger.dart';
import "package:flutter/material.dart";

import '../../../data/theme_controller.dart';
import '../../homepage/views/homepage_view.dart';
import '../../savedpage/views/savedpage_view.dart';
import '../../schedulepage/views/schedulepage_view.dart';
import '../../searchpage/views/searchpage_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final logger = Logger();

  final ThemeController themeController = Get.put(ThemeController());

  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    HomepageView(),
    SearchpageView(),
    SchedulepageView(),
    SavedpageView()
  ];

  @override
  void onInit() {
    super.onInit();
    logger.i("HomeController initialized");
  }

  @override
  void onReady() {
    super.onReady();
    logger.i("Home View is ready and visible");
  }

  @override
  void onClose() {
    super.onClose();
    logger.i("HomeController is being disposed");
  }
}
