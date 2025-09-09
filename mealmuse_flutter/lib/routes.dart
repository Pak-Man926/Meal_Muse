import "package:get/get.dart";
//import "package:mealmuse_flutter/views/homepage/homepage.dart";
import "package:mealmuse_flutter/app.dart";

class AppPages
{
  static final routes = [
    GetPage(
      name: "/apppage",
      page: () => AppPage(),
    )
  ];
}