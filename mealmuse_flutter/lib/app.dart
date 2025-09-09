import "package:flutter/material.dart";
import "package:get/get.dart";

import "controllers/theme_controller.dart";
import "routes.dart";
import "themes/theme.dart";

class AppPage extends StatelessWidget
{
  //const AppPage({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context)

  {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text ("Recipe Generator",
          style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.tune_rounded),
            onPressed: null,
            )
        ],
      ),
    );
  }
}