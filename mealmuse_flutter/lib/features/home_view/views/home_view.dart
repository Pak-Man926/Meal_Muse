import 'package:flutter/material.dart';

import 'package:get/get.dart';
import "../../../app/widgets/bottom_navigation_bar.dart";
import "../../../app/widgets/tune_icon_button_widget.dart";
//import "routes.dart";
//import "themes/theme.dart";
import '../presentation/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // final ThemeController themeController = Get.put(ThemeController());

  // var selectedIndex = 0.obs;

  // void _onItemTapped(int index) {
  //   selectedIndex.value = index;
  // }

  // final List<Widget> pages = [
  //   HomepageView(),
  //   SearchpageView(),
  //   SchedulepageView(),
  //   SavedpageView()
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Obx(() => controller.pages[controller.selectedIndex.value]),
      ),
      bottomNavigationBar: Obx(() => AppBottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onItemTapped,
          )),
    );
  }
}
