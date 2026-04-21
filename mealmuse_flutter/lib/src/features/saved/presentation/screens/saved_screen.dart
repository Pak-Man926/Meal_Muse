import "package:flutter/material.dart";
import "package:meal_muse/src/features/saved/presentation/screens/saved_breakfast_meals.dart";
import "package:meal_muse/src/features/saved/presentation/screens/combined_saved_meals.dart";
import "package:meal_muse/src/features/saved/presentation/screens/saved_drinks.dart";
import "package:meal_muse/src/features/saved/presentation/screens/saved_lunch_meals.dart";
import "package:meal_muse/src/features/saved/presentation/screens/saved_dinner_meals.dart";
import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Saved Recipes", style: AppTextStyles.pageTitle),
          centerTitle: true,
          bottom: TabBar(
            //padding: const EdgeInsets.all(10),
            dividerColor: AppColors.glassBorder,
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary.withOpacity(0.8),
            unselectedLabelColor: AppColors.mutedText,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Breakfast"),
              Tab(text: "Lunch"),
              Tab(text: "Dinner"),
              Tab(text: "Drinks"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CombinedSavedMeals(),
            SavedBreakFastMeals(),
            SavedLunchMeals(),
            SavedDinnerMeals(),
            SavedDrinks(),
          ],
        ),
      ),
    );
  }
}
