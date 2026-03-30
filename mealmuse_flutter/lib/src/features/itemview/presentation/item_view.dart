import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";

import "../../../core/themes/text_styles.dart";

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Pasta-Carbonara-Recipe-1.jpg"), // ?? AssetImage("assets/Chicken-stir-fry-V1.jpg"),
              fit: BoxFit.cover,
              ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
            mediumSpaceSize,
            Text("Creamy Tomato Pasta", style: AppTextStyles.subHeadingsText),
            smallSpaceSize,
            Text("A simple yet delicious pasta dish with a creamy tomato sauce. Perfect for a quick weeknight dinner. Total Time: 30 mins", style: AppTextStyles.bodyText),
            mediumSpaceSize,
            Text("Ingredients", style: AppTextStyles.subHeadingsText),
          ],
        ),
      ),
    );
  }
}
