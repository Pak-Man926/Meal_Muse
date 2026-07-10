import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/presentation/widgets/meal_card_widget.dart";
import "package:meal_muse/src/features/recipes/data/category_recipes_repository.dart";

class DessertRecipeListScreen extends StatelessWidget {
  final int? categoryId;
  const DessertRecipeListScreen({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Desserts",
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
              "Sweet Endings",
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            smallSpaceSize,
            Text(
              "Indulge in our collection of delectable dessert recipes, from classic favorites to innovative creations. Whether you're craving a rich chocolate cake, a refreshing fruit tart, or a creamy cheesecake, our dessert recipes are sure to satisfy your sweet tooth and impress your guests.",
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.clip,
              maxLines: 7,
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
                final dessertsCategoryRecipes = ref.watch(
                  categoryRecipesProvider(categoryId ?? 0),
                );

                return dessertsCategoryRecipes.when(
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
                            id: recipe.id,
                            mealType: "Desserts",
                            meal: recipe.name,
                            prepTime: recipe.totalTime,
                            composition:
                                recipe.ratingValue ??
                                0, // You can replace this with actual composition if available
                            imageAddress: fullImageUrl,
                            onTap: () {
                              context.push("/recipes/${recipe.id}");
                            },
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
