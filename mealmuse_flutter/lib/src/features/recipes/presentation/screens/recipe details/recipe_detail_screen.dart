import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/recipes/data/recipe_repository.dart";
import "package:meal_muse/src/features/recipes/presentation/widgets/recipe_details_widget.dart";
import "package:meal_muse/src/core/presentation/widgets/button_widget.dart";
import "package:meal_muse/src/features/recipes/presentation/widgets/ingredient_list_widget.dart";



class RecipeDetailScreen extends StatelessWidget {
  final int id;
  const RecipeDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Details", style: theme.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline_rounded,
              color: theme.colorScheme.primary.withOpacity(0.8),
            ),
            //isSelected: true ? AppColors.primary.withOpacity(0.8) : AppColors.bone,
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final recipeDetails = ref.watch(recipeDetailsProvider(id));
          return recipeDetails.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) =>
                Center(child: Text("Error fetching recipe details: $error")),
            data: (details) {
              final imagePath = details.images.isNotEmpty
                  ? details.images.first
                  : '';
              final fullImageUrl = imagePath.isNotEmpty
                  ? "$imageBaseUrl$imagePath"
                  : "https://via.placeholder.com/400";

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(fullImageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      smallSpaceSize,
                      Text(
                        details.name,
                        style: theme.textTheme.headlineMedium!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      mediumSpaceSize,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RecipeDetailsWidget(
                            title: "Total Time",
                            subTitle: "${details.totalTime} mins",
                          ),
                          const SizedBox(width: 10),
                          RecipeDetailsWidget(
                            title: "Servings",
                            subTitle: "${details.servings}",
                          ),
                          const SizedBox(width: 10),
                          RecipeDetailsWidget(
                            title: "Calories",
                            subTitle:
                                details.nutritionInfo?['Calories']
                                    ?.toString() ??
                                "N/A",
                          ),
                        ],
                      ),
                      smallSpaceSize,
                      CustomButton.primary(
                        icon: Icons.date_range_rounded,
                        text: "Add to Schedule",
                        onPressed: () {},
                      ),
                      smallSpaceSize,
                      Text(
                        "Ingredients",
                        style: theme.textTheme.headlineMedium,
                      ),
                      ListView.builder(
                        itemCount: details.ingredients.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              IngredientListWidget(
                                ingredients: details.ingredients[index],
                              ),
                              smallSpaceSize,
                            ],
                          );
                        },
                      ),
                      smallSpaceSize,
                      Text(
                        "Instructions",
                        style: theme.textTheme.headlineMedium,
                      ),
                      smallSpaceSize,
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => largeSpaceSize,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.instructions.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: theme.textTheme.labelMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  details.instructions[index],
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
