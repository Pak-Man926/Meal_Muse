import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "package:meal_muse/src/features/searchpage/data/container_widget.dart";

class SearchPageView extends StatelessWidget {
  const SearchPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: AppTextStyles.headingsText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: .start,
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Results", style: AppTextStyles.subHeadingsText),
            ),
            mediumSpaceSize,
          ],
        ),
      ),
    );
  }
}
