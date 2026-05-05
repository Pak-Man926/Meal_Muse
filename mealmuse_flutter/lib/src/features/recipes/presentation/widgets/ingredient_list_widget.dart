import "package:flutter/material.dart";
import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class IngredientListWidget extends StatelessWidget {
  final String ingredients;

  const IngredientListWidget({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        //contentPadding: EdgeInsets.all(10),
        leading: Icon(Icons.check_circle_rounded, size: 15),
        iconColor: theme.colorScheme.primary,
        title: Text(
          ingredients,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13,
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
