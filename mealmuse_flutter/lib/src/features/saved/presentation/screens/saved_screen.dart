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
    final theme = Theme.of(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Saved Recipes", style: theme.textTheme.titleLarge),
          centerTitle: true,
          bottom: TabBar(
            //padding: const EdgeInsets.all(10),
            dividerColor: theme.dividerColor,
            isScrollable: true,
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.primary.withOpacity(0.8),
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
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
