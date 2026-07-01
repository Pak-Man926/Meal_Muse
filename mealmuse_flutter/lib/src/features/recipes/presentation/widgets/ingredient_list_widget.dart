import "package:flutter/material.dart";

class IngredientListWidget extends StatelessWidget {
  final String ingredients;

  const IngredientListWidget({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      width: double.infinity,
      alignment: .centerLeft,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        //contentPadding: EdgeInsets.only(bottom:18.0, left: 12.0),
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
