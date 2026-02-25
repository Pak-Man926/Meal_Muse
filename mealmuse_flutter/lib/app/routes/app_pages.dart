import 'package:get/get.dart';

import '../modules/home_view/bindings/home_binding.dart';
import '../modules/home_view/views/home_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/savedpage/bindings/savedpage_binding.dart';
import '../modules/savedpage/views/savedpage_view.dart';
import '../modules/schedulepage/bindings/schedulepage_binding.dart';
import '../modules/schedulepage/views/schedulepage_view.dart';
import '../modules/searchpage/bindings/searchpage_binding.dart';
import '../modules/searchpage/views/searchpage_view.dart';
import '../modules/home_view/settingspage/bindings/settingspage_binding.dart';
import '../modules/home_view/settingspage/views/settingspage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => const HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.SAVEDPAGE,
      page: () => const SavedpageView(),
      binding: SavedpageBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULEPAGE,
      page: () => const SchedulepageView(),
      binding: SchedulepageBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHPAGE,
      page: () => const SearchpageView(),
      binding: SearchpageBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGSPAGE,
      page: () => const SettingspageView(),
      binding: SettingspageBinding(),
    ),
  ];
}
