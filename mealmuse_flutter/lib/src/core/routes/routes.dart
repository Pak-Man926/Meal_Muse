import "package:go_router/go_router.dart";
import "package:meal_muse/src/features/dashboard/presentation/dashboard_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/breakfast_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/dinner_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/lunch_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/recipe_detail_screen.dart";
import "package:meal_muse/src/features/settings/presentation/settings_screen.dart";

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => DashboardScreen()),
    GoRoute(path: "/settings", builder: (context, state) => SettingsScreen()),
    GoRoute(
      path: "/recipes",
      builder: (context, state) => RecipeDetailScreen(),
    ),
    GoRoute(
      path: "/breakfastrecipes",
      builder: (context, state) => BreakfastRecipeListScreen(),
    ),
    GoRoute(
      path: "/lunchrecipes",
      builder: (context, state) => LunchRecipeListScreen(),
    ),
    GoRoute(
      path: "/dinnerrecipes",
      builder: (context, state) => DinnerRecipeListScreen(),
    ),
  ],
);
