import "package:go_router/go_router.dart";
import "package:meal_muse/src/features/homeview/presentation/home_view.dart";
import "package:meal_muse/src/features/settingspage/presentation/settings_page.dart";

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: "/settings",
      builder: (context, state) => SettingsPageView(),
    ),
  ]
);