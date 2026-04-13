import "package:flutter/material.dart";
import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class IngredientListWidget extends StatelessWidget {
  final String ingredients;

  const IngredientListWidget({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.glassBorder.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        //contentPadding: EdgeInsets.all(10),
        leading: Icon(Icons.check_circle_rounded, size: 15),
        iconColor: AppColors.primary,
        title: Text(
          ingredients,
          style: AppTextStyles.bodyText.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
    //
    //
    // ListView.builder(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: ingredients.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       leading: Icon(Icons.check_circle_rounded, size: 15),
    //       title: Text(ingredients[index]),
    //     );
    //   },
    // );
  }
}
