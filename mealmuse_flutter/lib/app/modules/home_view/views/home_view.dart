import 'package:flutter/material.dart';

import 'package:get/get.dart';
import "../../../widgets/bottom_navigation_bar.dart";
import "../../../widgets/tune_icon_button_widget.dart";
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Recipe Generator",
            style: Theme.of(context).textTheme.displayLarge),
        actions: [
          TuneIconButtonWidget(
            onPressed: () => Get.toNamed("/settingspage"),
            iconSize: 30,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: controller.pages[controller.selectedIndex.value],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.onItemTapped,
      ),
    );
  }
}
