import "package:go_router/go_router.dart";
import "package:meal_muse/src/app.dart";

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MyApp(),
    ),
  ]
);