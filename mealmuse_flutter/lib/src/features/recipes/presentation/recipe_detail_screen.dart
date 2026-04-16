import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/recipes/data/ingredients_model.dart";
import "package:meal_muse/src/features/recipes/presentation/widgets/recipe_details_widget.dart";
import "package:meal_muse/src/models/widgets/button_widget.dart";
import "../../../core/themes/colors.dart";
import "widgets/ingredient_list_widget.dart";
import "widgets/saved_items_button.dart";

import "../../../core/themes/text_styles.dart";

class RecipeDetailScreen extends StatelessWidget {
  RecipeDetailScreen({super.key});

  final List<String> instructions = [
    "Boil a large pot of salted water and cook the pasta according to package instructions until al dente.",
    "While pasta cooks, melt butter in a large skillet over medium-low heat. Add minced garlic and cook for 2-3 minutes until fragrant but not browned,",
    "Reserve 1/2 cup of pasta water, then drain the pasta. Toss the pasta in the garlic butter skillet.",
    "Add permasan cheese and eggs to the skillet, stirring quickly to create a creamy sauce. If the sauce is too thick, add reserved pasta water a little at a time until desired consistency is reached.",
    "Serve immediately with extra Parmesan and black pepper.",
  ];

  final List<Ingredients> ingredients = [
    Ingredients(ingredients: "250g Spaghetti or Linguine"),
    Ingredients(ingredients: "4 Garlic cloves, minced"),
    Ingredients(ingredients: "150g Pancetta or Bacon, diced"),
    Ingredients(ingredients: "2 Large Eggs"),
    Ingredients(ingredients: "50g Grated Parmesan Cheese"),
    Ingredients(ingredients: "Salt and Black Pepper to taste"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Details", style: AppTextStyles.pageTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline_rounded,
              color: AppColors.primary.withOpacity(0.8),
            ),
            //isSelected: true ? AppColors.primary.withOpacity(0.8) : AppColors.bone,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/Pasta-Carbonara-Recipe-1.jpg",
                    ), // ?? AssetImage("assets/Chicken-stir-fry-V1.jpg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              smallSpaceSize,
              Text(
                "Homemade Pasta Carbonara",
                style: AppTextStyles.sectionHeader.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              mediumSpaceSize,
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  RecipeDetailsWidget(title: "Total Time", subTitle: "25 mins"),
                  const SizedBox(width: 10),
                  RecipeDetailsWidget(
                    title: "Servings",
                    subTitle: "2 portions",
                  ),
                  const SizedBox(width: 10),
                  RecipeDetailsWidget(
                    title: "Calories",
                    subTitle: "450 Calories",
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
              Text("Ingredients", style: AppTextStyles.sectionHeader),
              ListView.builder(
                itemCount: ingredients.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Ingredients ingredient = ingredients[index];
                  return Column(
                    children: [
                      IngredientListWidget(ingredients: ingredient.ingredients),
                      smallSpaceSize,
                      // IngredientListWidget(
                      //   ingredients: "4 Garlic cloves, minced",
                      // ),
                    ],
                  );
                },
              ),
              smallSpaceSize,
              Text("Instructions", style: AppTextStyles.sectionHeader),
              smallSpaceSize,
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => largeSpaceSize,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: instructions.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: .start,
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}".toString(),
                            style: AppTextStyles.labelMuted.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          instructions[index],
                          style: AppTextStyles.bodyText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      largeSpaceSize,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
