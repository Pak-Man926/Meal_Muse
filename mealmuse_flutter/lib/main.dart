import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
//import "package:logger/logger.dart";
import "app/themes/theme.dart";

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: "Meal Muse",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
