import "package:go_router/go_router.dart";
import "package:meal_muse/src/features/dashboard/presentation/screens/dashboard_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/baked_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/breakfast_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/deserts_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/dinner_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/drinks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/lunch_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/recipe_detail_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/snacks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/soups_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/trending_recipes_list_screen.dart";
import "package:meal_muse/src/features/settings/presentation/screens/settings_screen.dart";

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
