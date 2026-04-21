import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/saved/domain/recipe_model.dart";
import "package:meal_muse/src/features/saved/presentation/widgets/saved_item_widget.dart";
import "package:meal_muse/src/features/schedule/presentation/widgets/schedule_meal_card_widget.dart";
import "package:meal_muse/src/features/search/presentation/widgets/container_widget.dart";

import "../../../core/themes/colors.dart";
import "../../../core/themes/text_styles.dart";

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

class SnacksRecipeListScreen extends StatelessWidget {
  const SnacksRecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Snacks",
          style: AppTextStyles.pageTitle.copyWith(color: AppColors.primary),
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
              "Bite-Sized Delights",
              style: AppTextStyles.sectionHeader.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            smallSpaceSize,
            Text(
              "Quick bites and savory delights to keep you energized between meals. From crispy chips and creamy dips to wholesome energy bars and refreshing fruit salads, our snack recipes are perfect for satisfying your cravings and keeping you fueled throughout the day.",
              style: AppTextStyles.bodyText,
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
            Expanded(
              child: ListView.builder(
                itemCount: mySavedMeals.length,
                itemBuilder: (context, index) {
                  return ScheduleCardWidget(
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
