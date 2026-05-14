import "package:go_router/go_router.dart";
import "package:meal_muse/src/features/dashboard/presentation/screens/dashboard_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/baked_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/breakfast_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/desserts_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/dinner_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/drinks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/lunch_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/recipe%20details/recipe_detail_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/snacks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/soups_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/trending_recipes_list_screen.dart";
import "package:meal_muse/src/features/settings/presentation/screens/settings_screen.dart";
import "package:meal_muse/src/features/settings/presentation/screens/about_screen.dart";

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => DashboardScreen()),
    GoRoute(path: "/settings", builder: (context, state) => SettingsScreen()),
    GoRoute(path: "/about", builder: (context, state) => AboutScreen()),
    GoRoute(
      path: "/recipes/:id",
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return RecipeDetailScreen(id: id);
      },
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
      path: "/dessertrecipes",
      builder: (context, state) => DessertRecipeListScreen(),
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
