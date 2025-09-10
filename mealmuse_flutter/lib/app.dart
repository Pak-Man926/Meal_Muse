import "package:flutter/material.dart";
import "package:get/get.dart";

import "controllers/theme_controller.dart";
import "routes.dart";
import "themes/theme.dart";
import "widgets/tune_icon_button_widget.dart";

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
          style: Theme.of(context).textTheme.displayLarge),
        actions: [
         TuneIconButtonWidget(
          onPressed: ()
          {
            
          },
          iconSize: 30,
          color: Colors.black,
         ), 
        ],
      ),
    );
  }
}