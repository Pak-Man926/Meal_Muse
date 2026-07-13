import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/saved/data/get_saved_meals_repository.dart";
// import "package:meal_muse/src/features/saved/data/get_saved_meals_repository.dart";
// import "package:meal_muse/src/features/saved/presentation/screens/saved_breakfast_meals.dart";
// import "package:meal_muse/src/features/saved/presentation/screens/combined_saved_meals.dart";
// import "package:meal_muse/src/features/saved/presentation/screens/saved_drinks.dart";
// import "package:meal_muse/src/features/saved/presentation/screens/saved_lunch_meals.dart";
// import "package:meal_muse/src/features/saved/presentation/screens/saved_dinner_meals.dart";
import "package:meal_muse/src/features/saved/presentation/widgets/saved_item_widget.dart";

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Recipes", style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(getSavedMealsProvider)
              .when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      "Error fetching saved meals: $error",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
                data: (data) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      return await ref.refresh(getSavedMealsProvider);
                    },
                    child: Padding(
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
                          final savedResults = data.results[index];
                          final imagePath =
                              savedResults.recipe.images.isNotEmpty
                              ? savedResults.recipe.images.first
                              : '';
                          final fullImageUrl = imagePath.isNotEmpty
                              ? "$imageBaseUrl$imagePath"
                              : "https://via.placeholder.com/400";
                          return SavedItemWidget(
                            id: savedResults.recipe.id,
                            mealType: savedResults.mealType,
                            meal: savedResults.recipe.name,
                            prepTime: savedResults.recipe.totalTime,
                            composition: 0,
                            imageAddress: fullImageUrl,
                            onTap: () {
                              context.push(
                                "/recipes/${savedResults.recipe.id}",
                              );
                            },
                          );
                        },
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

// Widget build(BuildContext context) {
//   return DefaultTabController(
//     initialIndex: 0,
//     length: 5,
//     child: Scaffold(
//         bottom: TabBar(
//           //padding: const EdgeInsets.all(10),
//           dividerColor: theme.dividerColor,
//           isScrollable: true,
//           indicatorColor: theme.colorScheme.primary,
//           labelColor: theme.colorScheme.primary.withOpacity(0.8),
//           unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
//           tabs: [
//             Tab(text: "All"),
//             Tab(text: "Breakfast"),
//             Tab(text: "Lunch"),
//             Tab(text: "Dinner"),
//             Tab(text: "Drinks"),
//           ],
//         ),
//       ),
//       body: const TabBarView(
//         children: [
//           CombinedSavedMeals(),
//           SavedBreakFastMeals(),
//           SavedLunchMeals(),
//           SavedDinnerMeals(),
//           SavedDrinks(),
//         ],
//       ),
//     ),
//   );
// }
