import "package:flutter/material.dart";

class HomeView extends StatelessWidget {
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
      // body: SafeArea(
      //   top: false,
      //   bottom: true,
      // //   child: Obx(() => controller.pages[controller.selectedIndex.value]),
      // // ),
      // bottomNavigationBar: Obx(() => AppBottomNavigationBar(
      //       currentIndex: controller.selectedIndex.value,
      //       onTap: controller.onItemTapped,
      //     )),
    );
  }
}