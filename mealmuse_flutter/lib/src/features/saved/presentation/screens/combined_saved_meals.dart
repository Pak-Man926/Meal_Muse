import "package:flutter/material.dart";
import "package:meal_muse/src/features/saved/domain/recipe_model.dart";
import "package:meal_muse/src/features/saved/presentation/widgets/saved_item_widget.dart";

final List<Recipe> mySavedMeals = [
  Recipe(
    mealType: "Dinner",
    meal: "Mediterranean Pasta",
    prepTime: 35,
    composition: 580,
    imageAddress: "assets/mediterranean-pasta-sq-1.jpg",
  ),
  Recipe(
    mealType: "Breakfast",
    meal: "Poached Eggs & Salad",
    prepTime: 15,
    composition: 320,
    imageAddress: "assets/avocado-6b1cf76.jpg",
  ),
  Recipe(
    mealType: "Lunch",
    meal: "Miso Glazed Salmon",
    prepTime: 25,
    composition: 450,
    imageAddress:
        "assets/feb20_salmon-salad-with-sesame-miso-dressing-taste-157324-1.jpg",
  ),
  Recipe(
    meal: "Fluffy Pancakes",
    prepTime: 20,
    composition: 45,
    imageAddress: "assets/Fluffy-Pancakes-Featured.jpg",
  ),
];

class CombinedSavedMeals extends StatelessWidget {
  const CombinedSavedMeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemCount: mySavedMeals.length,
          itemBuilder: (BuildContext context, int index) {
            Recipe currentRecipe = mySavedMeals[index];
            return SavedItemWidget(
              mealType: currentRecipe.mealType,
              meal: currentRecipe.meal,
              prepTime: currentRecipe.prepTime,
              composition: currentRecipe.composition,
              imageAddress: currentRecipe.imageAddress,
            );
          },
        ),
      ),
    );
  }
}
