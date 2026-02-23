import 'package:flutter/material.dart';
//import 'package:serverpod_flutter/serverpod_flutter.dart';
//import "package:google_fonts/google_fonts.dart";
import "package:get/get.dart";
//import "views/homepage.dart";
import "routes.dart";
import "themes/theme.dart";


late String serverUrl;

void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: "/apppage",
      getPages: AppPages.routes,
    );
  }
}

