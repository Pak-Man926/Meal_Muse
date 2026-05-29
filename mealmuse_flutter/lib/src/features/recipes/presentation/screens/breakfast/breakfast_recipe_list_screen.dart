import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/presentation/widgets/meal_card_widget.dart";
import "package:meal_muse/src/core/presentation/widgets/container_widget.dart";
import "package:meal_muse/src/features/recipes/data/category_recipes_repository.dart";



class BreakfastRecipeListScreen extends StatelessWidget {
  final int? categoryId;
  const BreakfastRecipeListScreen({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Breakfast",
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
              "Breakfast Recipes",
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            smallSpaceSize,
            Text(
              "Start your day right with our curated collection of delicious and energizing breakfast recipes. From quick and easy options to hearty and indulgent meals, we have something for everyone.",
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.clip,
              maxLines: 5,
            ),
            smallSpaceSize,
            SizedBox(
              height: 35,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ContainerWidget(
                    label: "All Recipes",
                    isActive: true,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  ContainerWidget(
                    label: "Quick & Easy",
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                  ),
                  const SizedBox(width: 10),
                  ContainerWidget(
                    label: "Healthy",
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                  ),
                  const SizedBox(width: 10),
                  ContainerWidget(label: "Quick & Easy"),
                  const SizedBox(width: 10),
                  ContainerWidget(label: "Healthy"),
                ],
              ),
            ),
            smallSpaceSize,
            Consumer(
              builder: (context, ref, child) {
                final breakfastCategoryRecipes = ref.watch(
                  categoryRecipesProvider(categoryId ?? 0),
                );

                return breakfastCategoryRecipes.when(
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
                            mealType: "Breakfast",
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
