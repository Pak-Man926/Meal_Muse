import "package:go_router/go_router.dart";
import "package:meal_muse/src/features/dashboard/presentation/dashboard_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/baked_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/breakfast_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/deserts_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/dinner_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/drinks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/lunch_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/recipe_detail_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/snacks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/soups_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/trending_recipes_list_screen.dart";
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
    GoRoute(
      path: "/drinkrecipes",
      builder: (context, state) => DrinksRecipeListScreen(),
    ),
    GoRoute(
      path: "/desertrecipes",
      builder: (context, state) => DesertRecipeListScreen(),
    ),
    GoRoute(
      path: "/souprecipes",
      builder: (context, state) => SoupRecipeListScreen(),
    ),
    GoRoute(
      path: "/snackrecipes",
      builder: (context, state) => SnacksRecipeListScreen(),
    ),
    GoRoute(
      path: "/bakedrecipes",
      builder: (context, state) => BakedRecipeListScreen(),
    ),
    GoRoute(
      path: "/trendingrecipes",
      builder: (context, state) => TrendingRecipesListScreen(),
    ),
  ],
);
