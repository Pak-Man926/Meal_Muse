import 'package:get/get.dart';

import '../../features/home_view/bindings/home_binding.dart';
import '../../features/home_view/presentation/pages/home_view.dart';
import '../../features/homepage/bindings/homepage_binding.dart';
import '../../features/homepage/views/homepage_view.dart';
import '../../features/savedpage/bindings/savedpage_binding.dart';
import '../../features/savedpage/views/savedpage_view.dart';
import '../../features/schedulepage/bindings/schedulepage_binding.dart';
import '../../features/schedulepage/views/schedulepage_view.dart';
import '../../features/searchpage/bindings/searchpage_binding.dart';
import '../../features/searchpage/views/searchpage_view.dart';
import '../../features/settingspage/bindings/settingspage_binding.dart';
import '../../features/settingspage/views/settingspage_view.dart';

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
