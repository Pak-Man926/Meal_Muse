import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/home/presentation/widgets/categories_button.dart";
import "package:meal_muse/src/core/presentation/widgets/meal_card_widget.dart";
import "package:meal_muse/src/features/recipes/data/category_recipes_repository.dart";


class DrinksRecipeListScreen extends StatelessWidget {
  final int? categoryId;
  const DrinksRecipeListScreen({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Drinks",
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
              "Artisanal Sips",
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            smallSpaceSize,
            Text(
              "Discover a curated collection of liquid inspirations, from sophisticated midnight cocktails to vibrant morning juices. Our drink recipes are crafted to elevate your sipping experience, whether you're unwinding after a long day or kickstarting your morning with a burst of flavor.",
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.clip,
              maxLines: 7,
            ),
            smallSpaceSize,
            Container(
              height: 90,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoriesButton(
                    icon: Icons.local_bar_rounded,
                    title: "Cocktails",
                  ),
                  const SizedBox(width: 10),
                  CategoriesButton(icon: Icons.coffee, title: "Coffee"),
                  const SizedBox(width: 10),
                  CategoriesButton(
                    icon: Icons.blender_rounded,
                    title: "Smoothies",
                  ),
                  const SizedBox(width: 10),
                  CategoriesButton(
                    icon: Icons.water_drop_rounded,
                    title: "Juices",
                  ),
                  const SizedBox(width: 10),
                  CategoriesButton(icon: Icons.wine_bar_rounded, title: "Wine"),
                ],
              ),
            ),
            smallSpaceSize,
            Consumer(
              builder: (context, ref, child) {
                final drinksCategoryRecipes = ref.watch(
                  categoryRecipesProvider(categoryId ?? 0),
                );

                return drinksCategoryRecipes.when(
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
                            mealType: "Drinks",
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
