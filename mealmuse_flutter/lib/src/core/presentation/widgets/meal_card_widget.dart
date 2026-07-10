import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import 'package:meal_muse/src/core/presentation/widgets/button_widget.dart';
import "package:meal_muse/src/features/saved/data/add_saved_meals_repository.dart";
import "package:meal_muse/src/features/saved/data/get_saved_meals_repository.dart";
import "package:meal_muse/src/features/saved/data/remove_saved_meals_repository.dart";

class MealCardWidget extends StatelessWidget {
  final int id;
  final String? mealType;
  final String meal;
  final int prepTime;
  final int composition;
  final String imageAddress;
  final Function()? onTap;

  const MealCardWidget({
    super.key,
    this.mealType,
    required this.meal,
    required this.prepTime,
    required this.composition,
    required this.imageAddress,
    required this.id,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logger = Logger();
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: imageAddress.startsWith('http')
                ? Image.network(imageAddress, fit: BoxFit.cover)
                : Image.asset(imageAddress, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        meal,
                        style: theme.textTheme.headlineMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final savedMealsAsync = ref.watch(
                          getSavedMealsProvider,
                        );

                        final isSaved = savedMealsAsync.maybeWhen(
                          data: (savedMeals) => savedMeals.results.any(
                            (result) => result.recipe.id == id,
                          ),
                          orElse: () => false,
                        );

                        //final removeSavedMealsAsync = ref.watch(removeSavedMealsProvider(id));

                        return IconButton.filled(
                          // Use the state variable here
                          isSelected: isSaved,
                          onPressed: () async {
                            if (isSaved) {
                              await RemoveSavedMealsRepository()
                                  .removedSavedMeals(id);

                              ref.invalidate(getSavedMealsProvider);

                              logger.i(
                                "Recipe with ID $id has been removed from favourites.",
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Recipe has been removed from favourites!",
                                  ),
                                ),
                              );
                            } else {
                              try {
                                await AddSavedMealsRepository()
                                    .addFavouriteMeal(id);

                                ref.invalidate(getSavedMealsProvider);

                                logger.i(
                                  "Recipe with ID $id added to favourites.",
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Added to favourites!"),
                                  ),
                                );
                              } catch (e) {
                                logger.e("Error adding to favourites: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
                            }
                          },
                          // The default icon (when NOT selected / empty)
                          icon: Icon(
                            Icons.favorite_outline_rounded,
                            color: theme.colorScheme.primary.withOpacity(0.8),
                          ),
                          // The icon when selected (when IS selected / full)
                          selectedIcon: Icon(
                            Icons
                                .favorite_rounded, // Changed to the filled version
                            color: theme
                                .colorScheme
                                .surface, // Use primary color with opacity for the filled icon
                          ),
                        );
                      },
                    ),
                  ],
                ),
                smallSpaceSize,
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: 20,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text("$prepTime min", style: theme.textTheme.labelMedium),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.local_fire_department,
                      size: 20,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$composition kcal",
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
                smallSpaceSize,
                CustomButton.primary(text: "View Recipe", onPressed: onTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
