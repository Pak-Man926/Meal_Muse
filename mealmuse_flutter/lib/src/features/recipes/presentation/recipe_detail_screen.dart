import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "widgets/saved_items_button.dart";

import "../../../core/themes/text_styles.dart";

class RecipeDetailScreen extends StatelessWidget {
  RecipeDetailScreen({super.key});

  final List<String> instructions = [
    "Boil the pasta in salted water until al dente.",
    "In a separate pan, cook the pancetta until crispy.",
    "In a bowl, whisk together eggs and grated Parmesan cheese.",
    "Drain the pasta and return it to the pot. Mix in the pancetta and egg mixture quickly to create a creamy sauce.",
    "Serve immediately with extra Parmesan and black pepper.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Creamy Tomato Pasta",
          style: AppTextStyles.subHeadingsText,
        ),
        centerTitle: true,
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
                "A simple yet delicious pasta dish with a creamy tomato sauce. Perfect for a quick weeknight dinner. Total Time: 30 mins",
                style: AppTextStyles.bodyText,
              ),
              mediumSpaceSize,
              Text("Ingredients", style: AppTextStyles.subHeadingsText),
              smallSpaceSize,
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.check_box_outline_blank, size: 15),
                    title: Text(
                      "Ingredient ${index + 1}",
                      style: AppTextStyles.bodyText,
                    ),
                  );
                },
              ),
              smallSpaceSize,
              Text("Instructions", style: AppTextStyles.subHeadingsText),
              smallSpaceSize,
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => smallSpaceSize,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: instructions.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: .start,
                    children: [
                      Icon(Icons.list, size: 12),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          instructions[index],
                          style: AppTextStyles.bodyText,
                        ),
                      ),
                    ],
                  );
                },
              ),
              smallSpaceSize,
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  ViewItemsButton.primary(label: "Save Recipe"),
                  ViewItemsButton(label: "Add to Schedule"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
