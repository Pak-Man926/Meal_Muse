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
    return Container(
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.glassBorder,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.charcoal.withOpacity(0.2)),
      ),
      foregroundDecoration: BoxDecoration(
        color: AppColors.glassBorder.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(
            title,
            style: AppTextStyles.labelMuted.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          smallSpaceSize,
          Text(
            subTitle,
            style: AppTextStyles.bodyText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
