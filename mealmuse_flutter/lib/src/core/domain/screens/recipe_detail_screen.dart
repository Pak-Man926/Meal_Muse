import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/presentation/widgets/day_selection_widget.dart";
import "package:meal_muse/src/features/recipes/data/recipe_repository.dart";
import "package:meal_muse/src/features/recipes/presentation/widgets/recipe_details_widget.dart";
import "package:meal_muse/src/core/presentation/widgets/button_widget.dart";
import "package:meal_muse/src/features/recipes/presentation/widgets/ingredient_list_widget.dart";
import "package:meal_muse/src/features/schedule/data/add_schedule_repository.dart";

final logger = Logger();

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
          // final addToSchedule = ref.watch(addScheduleProvider({
          //   "recipeId": id,
          //   "dayOfWeek": "Monday",
          //   "mealType": "Lunch",
          // }));
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
                          // image: DecorationImage(
                          //   image: NetworkImage(fullImageUrl),
                          //   fit: BoxFit.cover,
                          // ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            fullImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: theme.colorScheme.surfaceContainer,
                                child: const Center(
                                  child: Icon(Icons.broken_image, size: 50),
                                ),
                              );
                            },
                          ),
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
                            subTitle: details.servings.toString(),
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
                        onPressed: () {
                          //Implement the modalsheet here
                          _showAddToScheduleModalSheet(context);
                        },
                      ),
                      mediumSpaceSize,
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

  void _showAddToScheduleModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        String selectedDay = "Monday";
        String selectedMealType = "Breakfast";
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer(
              builder: (context, ref, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      DaySelectionWidget(
                        selectedDay: selectedDay,
                        onDaySelected: (day) {
                          setState(() {
                            selectedDay = day;
                          });
                        },
                      ),
                      mediumSpaceSize,
                      Text(
                        "Select Meal Type",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      smallSpaceSize,
                      DropdownButton<String>(
                        value: selectedMealType,
                        items: ["Breakfast", "Lunch", "Dinner"]
                            .map(
                              (meal) => DropdownMenuItem(
                                value: meal,
                                child: Text(meal),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedMealType = value;
                            });
                          }
                        },
                      ),
                      mediumSpaceSize,
                      CustomButton.primary(
                        icon: Icons.check,
                        text: "Confirm",
                        onPressed: () async {
                          logger.i(
                            "Adding recipe with ID $id to schedule on ${selectedDay.toLowerCase()} for $selectedMealType",
                          );
                          try {
                            await ref.read(
                              addScheduleProvider((
                                recipeId: id,
                                dayOfWeek: selectedDay.toLowerCase(),
                                mealType: selectedMealType.toLowerCase(),
                              )).future,
                            );
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Added to schedule!"),
                              ),
                            );
                          } catch (e) {
                            logger.e("Error adding to schedule: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
