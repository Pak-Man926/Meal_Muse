import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "widgets/container_widget.dart";

import "../../recipes/presentation/widgets/recipe_card_widget.dart";

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: AppTextStyles.pageTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for recipes",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
            mediumSpaceSize,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ContainerWidget(label: "Quick Recipes"),
                ContainerWidget(label: "Healthy"),
                ContainerWidget(label: "Vegan"),
                ContainerWidget(label: "Gluten-free"),
                ContainerWidget(label: "Italian"),
                ContainerWidget(label: "Under 30 minutes"),
                ContainerWidget(label: "Breakfast"),
              ],
            ),
            mediumSpaceSize,
            Text("Results", style: AppTextStyles.sectionHeader),
            mediumSpaceSize,
            RecipeCardWidget(
              image: Image.asset("assets/Chicken-stir-fry-V1.jpg"),
              heading: "Chicken Stir Fry",
              subHeading: "30 mins | 4 servings",
            ),
            mediumSpaceSize,
            RecipeCardWidget(
              image: Image.asset("assets/Fluffy-Pancakes-Featured.jpg"),
              heading: "Fluffy Pancakes",
              subHeading: "20 mins | 4 servings",
            ),
            mediumSpaceSize,
            RecipeCardWidget(
              image: Image.asset("assets/Pasta-Carbonara-Recipe-1.jpg"),
              heading: "Pasta Carbonara",
              subHeading: "25 mins | 4 servings",
            ),
            mediumSpaceSize,
            RecipeCardWidget(
              image: Image.asset("assets/vegetable-curry-recipe.jpg"),
              heading: "Vegetable Curry",
              subHeading: "30 mins | 4 servings",
            ),
            mediumSpaceSize,
            RecipeCardWidget(
              image: Image.asset(
                "assets/201005-r-xl-grilled-chicken-tacos-2000-63b2b629eace4d71a7ee63529e252c38.jpg",
              ),
              heading: "Chicken Tacos",
              subHeading: "48 mins | 4 servings",
            ),
            mediumSpaceSize,
            RecipeCardWidget(
              image: Image.asset(
                "assets/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2007__04__honey-glazed-roast-chicken-horiz-a-1800-2057270028084ff2bdb54fcb0f2d3227.jpg",
              ),
              heading: "Honey Glazed Roast Chicken",
              subHeading: "1 hour | 4 servings",
            ),
          ],
        ),
      ),
    );
  }
}
