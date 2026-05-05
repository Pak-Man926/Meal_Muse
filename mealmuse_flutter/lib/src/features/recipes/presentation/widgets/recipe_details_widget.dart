import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class RecipeDetailsWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const RecipeDetailsWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.2)),
      ),
      foregroundDecoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(
            title,
            style: theme.textTheme.labelMedium!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          smallSpaceSize,
          Text(
            subTitle,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
