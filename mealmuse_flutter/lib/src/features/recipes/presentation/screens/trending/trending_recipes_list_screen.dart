import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:logger/logger.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/presentation/widgets/meal_card_widget.dart";
import "package:meal_muse/src/core/presentation/widgets/container_widget.dart";
import "package:meal_muse/src/features/home/data/trending_recipe_repository.dart";

class TrendingRecipesListScreen extends StatelessWidget {
  const TrendingRecipesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logger = Logger();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending Recipes",
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
            // Text(
            //   "Breakfast Recipes",
            //   style: AppTextStyles.sectionHeader.copyWith(
            //     fontSize: 26,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // smallSpaceSize,
            // Text(
            //   "Start your day right with our curated collection of delicious and energizing breakfast recipes. From quick and easy options to hearty and indulgent meals, we have something for everyone.",
            //   style: AppTextStyles.bodyText,
            //   overflow: TextOverflow.clip,
            //   maxLines: 5,
            // ),
            smallSpaceSize,
            Container(
              height: 30,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ContainerWidget.extended(
                    label: "All Recipes",
                    isActive: true,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                  ),
                  const SizedBox(width: 10),
                  ContainerWidget.extended(label: "Quick & Easy"),
                  const SizedBox(width: 10),
                  ContainerWidget.extended(label: "Healthy"),
                  const SizedBox(width: 10),
                  ContainerWidget.extended(label: "Quick & Easy"),
                  const SizedBox(width: 10),
                  ContainerWidget.extended(label: "Healthy"),
                ],
              ),
            ),
            smallSpaceSize,
            Consumer(
              builder: (context, ref, child) {
                final trendingRecipeState = ref.watch(trendingRecipeProvider);

                return trendingRecipeState.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) {
                    logger.e("Widget failed to render recipes", error: error);
                    return const Center(
                      child: Text("Error fetching trending recipes."),
                    );
                  },
                  data: (trendingData) {
                    if (trendingData.results.isEmpty) {
                      return const Center(
                        child: Text("No trending recipes available."),
                      );
                    }

                    logger.i(
                      "Trending recipes fetched successfully: ${trendingData.results.toList()}.",
                    );

                    return Expanded(
                      child: ListView.builder(
                        itemCount: trendingData.results.length,
                        itemBuilder: (context, index) {
                          final recipe = trendingData.results[index];
                          final imagePath = recipe.images.isNotEmpty
                              ? recipe.images.first
                              : '';
                          final fullImageUrl = imagePath.isNotEmpty
                              ? "$imageBaseUrl$imagePath"
                              : "https://via.placeholder.com/400";

                          return MealCardWidget(
                            id: recipe.id,
                            mealType: "Trending Recipe",
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
