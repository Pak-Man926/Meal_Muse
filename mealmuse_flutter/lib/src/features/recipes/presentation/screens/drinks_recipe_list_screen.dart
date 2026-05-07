import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/home/presentation/widgets/categories_button.dart";
import "package:meal_muse/src/features/saved/domain/recipe_model.dart";
import "package:meal_muse/src/features/saved/presentation/widgets/saved_item_widget.dart";
import "package:meal_muse/src/core/presentation/widgets/meal_card_widget.dart";
import "package:meal_muse/src/core/presentation/widgets/container_widget.dart";

import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

final List<Recipe> mySavedMeals = [
  Recipe(
    mealType: "Breakfast",
    meal: "Blueberry Pancakes",
    prepTime: 20,
    composition: 580,
    imageAddress: "assets/Fluffy-blueberry-pancakes-1.jpg",
  ),
  Recipe(
    mealType: "Breakfast",
    meal: "Avocado Toast",
    prepTime: 10,
    composition: 320,
    imageAddress: "assets/Avocado-Toast-SpendWithPennies-1.jpg",
  ),
  Recipe(
    mealType: "Breakfast",
    meal: "Eggs Benedict",
    prepTime: 35,
    composition: 450,
    imageAddress:
        "assets/17205-eggs-benedict-DDMFS-4x3-a0042d5ae1da485fac3f468654187db0.jpg",
  ),
  Recipe(
    mealType: "Breakfast",
    meal: "Berry Smoothie Bowl",
    prepTime: 15,
    composition: 45,
    imageAddress: "assets/Protein-Berry-Smoothie-Bowl-1.jpg",
  ),
];

class DrinksRecipeListScreen extends StatelessWidget {
  const DrinksRecipeListScreen({super.key});

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
            Expanded(
              child: ListView.builder(
                itemCount: mySavedMeals.length,
                itemBuilder: (context, index) {
                  return MealCardWidget(
                    mealType: mySavedMeals[index].mealType!,
                    meal: mySavedMeals[index].meal,
                    prepTime: mySavedMeals[index].prepTime,
                    composition: mySavedMeals[index].composition,
                    imageAddress: mySavedMeals[index].imageAddress,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
