import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/colors.dart";

import "package:meal_muse/src/core/themes/text_styles.dart";

class CategoriesButton extends StatelessWidget {
  final IconData icon; // Change Icon to IconData
  final String title;
  final VoidCallback? onPressed;

  const CategoriesButton({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: onPressed,
          //hoverColor: AppColors.primary.withOpacity(0.2),
          shape: CircleBorder(
            //borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.bone,
            child: Center(
              child: IconButton(
                // Create the Icon widget here to apply the color
                icon: Icon(icon, size: 20, color: AppColors.primary),
                //highlightColor: AppColors.primary.withOpacity(0.2),
                onPressed: onPressed,
              ),
            ),
          ),
        ),
        tinySpaceSize, // Assuming tinySpaceSize is a constant
        Text(
          title,
          style: AppTextStyles.bodyText.copyWith(fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
