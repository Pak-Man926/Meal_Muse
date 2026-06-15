import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/presentation/widgets/meal_card_widget.dart";
import "package:meal_muse/src/features/recipes/data/category_recipes_repository.dart";

class LunchRecipeListScreen extends StatelessWidget {
  final int? categoryId;
  const LunchRecipeListScreen({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lunch",
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Text(
              "Midday essentials",
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            smallSpaceSize,
            Text(
              "Fuel your afternoon with our selection of hearty and healthy lunch options, designed to keep you energized and satisfied throughout the day.",
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.clip,
              maxLines: 5,
            ),
            // smallSpaceSize,
            // Container(
            //   height: 30,
            //   width: double.infinity,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       ContainerWidget.extended(label: "All Recipes"),
            //       const SizedBox(width: 10),
            //       ContainerWidget.extended(label: "Quick & Easy"),
            //       const SizedBox(width: 10),
            //       ContainerWidget.extended(label: "Healthy"),
            //       const SizedBox(width: 10),
            //       ContainerWidget.extended(label: "Quick & Easy"),
            //       const SizedBox(width: 10),
            //       ContainerWidget.extended(label: "Healthy"),
            //     ],
            //   ),
            // ),
            mediumSpaceSize,
            Consumer(
              builder: (context, ref, child) {
                final lunchCategoryRecipes = ref.watch(
                  categoryRecipesProvider(categoryId ?? 0),
                );

                return lunchCategoryRecipes.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      const Center(child: Text("Error fetching recipes")),
                  data: (recipes) {
                    if (recipes.results.isEmpty) {
                      return const Center(child: Text("No recipes available."));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: recipes.results.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes.results[index];
                          final imagePath = recipe.images.isNotEmpty
                              ? recipe.images.first
                              : '';
                          final fullImageUrl = imagePath.isNotEmpty
                              ? "$imageBaseUrl$imagePath"
                              : "https://via.placeholder.com/400";

                          return MealCardWidget(
                            mealType: "Lunch",
                            meal: recipe.name,
                            prepTime: recipe.totalTime,
                            composition:
                                recipe.ratingValue ??
                                0, // You can replace this with actual composition if available
                            imageAddress: fullImageUrl,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
