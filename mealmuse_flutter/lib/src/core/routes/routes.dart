import "package:go_router/go_router.dart";
import "package:meal_muse/src/features/dashboard/presentation/screens/dashboard_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/baked/baked_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/breakfast/breakfast_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/desserts/desserts_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/dinner/dinner_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/drinks/drinks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/lunch/lunch_recipe_list_screen.dart";
import "package:meal_muse/src/core/domain/screens/recipe_detail_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/snacks/snacks_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/soups/soups_recipe_list_screen.dart";
import "package:meal_muse/src/features/recipes/presentation/screens/trending/trending_recipes_list_screen.dart";
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
      path: "/breakfast",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return BreakfastRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/lunch",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return LunchRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/dinner",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return DinnerRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/drinks",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return DrinksRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/desserts",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return DessertRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/soups",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return SoupRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/snacks",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return SnacksRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/bakedfoods",
      builder: (context, state) {
        final categoryId = state.extra as int?;
        return BakedRecipeListScreen(categoryId: categoryId);
      },
    ),
    GoRoute(
      path: "/trendingrecipes",
      builder: (context, state) => TrendingRecipesListScreen(),
    ),
  ],
);
