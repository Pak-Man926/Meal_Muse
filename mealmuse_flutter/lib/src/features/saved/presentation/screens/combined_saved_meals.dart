import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/saved/data/get_saved_meals_repository.dart";
import "package:meal_muse/src/features/saved/presentation/widgets/saved_item_widget.dart";

class CombinedSavedMeals extends ConsumerWidget {
  const CombinedSavedMeals({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(getSavedMealsProvider)
              .when(
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      "Error fetching saved meals: $error",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.6,
                          ),
                      itemCount: data.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        final result = data.results[index];
                        final imagePath = result.recipe.images.isNotEmpty
                            ? result.recipe.images.first
                            : '';
                        final fullImageUrl = imagePath.isNotEmpty
                            ? "$imageBaseUrl$imagePath"
                            : "https://via.placeholder.com/400";
                        //Recipe currentRecipe = data.results[index];
                        return SavedItemWidget(
                          mealType: result.mealType,
                          meal: result.recipe.name,
                          prepTime: result.recipe.totalTime,
                          composition: 0,
                          imageAddress: fullImageUrl,
                        );
                      },
                    ),
                  );
                },
              );
        },
      ),
    );
  }
}
