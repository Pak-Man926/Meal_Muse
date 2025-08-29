import "package:get/get.dart";
import "package:mealmuse_flutter/views/homepage.dart";

class AppPages
{
  static final routes = [
    GetPage(
      name: "/homepage",
      page: () => const Homepage(),
    )
  ];
}