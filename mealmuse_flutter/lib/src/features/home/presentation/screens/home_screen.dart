import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/home/data/trending_repository.dart';
import 'package:meal_muse/src/features/home/presentation/models/carousel_items.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/carousel_slider_widget.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/categories_button.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/tune_icon_button_widget.dart';
import 'package:meal_muse/src/features/recipes/data/recipe_repository.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logger = Logger();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meal Muse", style: theme.textTheme.titleLarge),
        actions: [
          TuneIconButtonWidget(
            onPressed: () {
              context.push("/settings");
            },
            iconSize: 30,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text("Trending Recipes", style: theme.textTheme.headlineMedium),
                TextButton(
                  onPressed: () {
                    context.push("/trendingrecipes");
                  },
                  child: Text(
                    "See All",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            mediumSpaceSize,
            // Inside your HomeScreen Consumer:
            // Inside your HomeScreen build method:
            Consumer(
              builder: (context, ref, child) {
                final trendingRecipeState = ref.watch(trendingRecipeProvider);

                return trendingRecipeState.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),

                  error: (error, stack) {
                    // UI logging for specific widget failures
                    Logger().e("Widget failed to render recipes", error: error);
                    return const Center(
                      child: Text("Error fetching trending recipes."),
                    );
                  },

                  data: (trendingData) {
                    // trendingData is your TrendingRecipes wrapper object.
                    // We need to map over its "results" list.
                    if (trendingData.results.isEmpty) {
                      return const Center(
                        child: Text("No trending recipes available."),
                      );
                    }

                    final mealItems = trendingData.results.map((recipe) {
                      // Safely grab the image and prepend your API Base URL
                      // because your API returns relative paths like "/uploads/..."
                      final imagePath = recipe.images.isNotEmpty
                          ? recipe.images.first
                          : '';

                      // Using imageBaseUrl from constants.dart which automatically
                      // removes the /api suffix from your API_URL
                      final fullImageUrl = imagePath.isNotEmpty
                          ? "$imageBaseUrl$imagePath"
                          : "https://via.placeholder.com/400"; // Fallback if no image

                      return CarouselItems(
                        id: recipe.id,
                        imageUrls: fullImageUrl,
                        title: recipe.name,
                        duration: recipe.totalTime,
                        // Use the description if it's not null, otherwise fallback to slug
                        description:
                            recipe.description?.toString() ?? recipe.slug,
                      );
                    }).toList();

                    return CarouselSliderWidget(
                      items: mealItems,
                      onTap: (tappedItem) {
                        Logger().i(
                          "Tapped on a trending recipe: ${tappedItem.title} ${tappedItem.id}",
                        );
                        context.push("/recipes/${tappedItem.id}");
                      },
                    );
                  },
                );
              },
            ),
            minSpaceSize,
            Text("Popular Categories", style: theme.textTheme.headlineMedium),
            mediumSpaceSize,
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: [
                  CategoriesButton(
                    icon: Icons.free_breakfast_rounded,
                    title: "Breakfast",
                    onPressed: () {
                      context.push("/breakfastrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.lunch_dining_rounded,
                    title: "Lunch",
                    onPressed: () {
                      context.push("/lunchrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.dinner_dining_rounded,
                    title: "Dinner",
                    onPressed: () {
                      context.push("/dinnerrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.wine_bar_rounded,
                    title: "Drinks",
                    onPressed: () {
                      context.push("/drinkrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.icecream,
                    title: "Desserts",
                    onPressed: () {
                      context.push("/dessertrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.soup_kitchen_rounded,
                    title: "Soups",
                    onPressed: () {
                      context.push("/souprecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.restaurant,
                    title: "Snacks",
                    onPressed: () {
                      context.push("/snackrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.bakery_dining_rounded,
                    title: "Baked Foods",
                    onPressed: () {
                      context.push("/bakedrecipes");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
