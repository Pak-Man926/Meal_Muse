import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";


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
    final theme = Theme.of(context);
    return Column(
      children: [
        MaterialButton(
          onPressed: onPressed,
          //hoverColor: AppColors.primary.withOpacity(0.2),
          shape: CircleBorder(
            //borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.surfaceContainerLow,
            child: Center(
              child: IconButton(
                // Create the Icon widget here to apply the color
                icon: Icon(icon, size: 20, color: theme.colorScheme.primary),
                //highlightColor: AppColors.primary.withOpacity(0.2),
                onPressed: onPressed,
              ),
            ),
          ),
        ),
        tinySpaceSize, // Assuming tinySpaceSize is a constant
        Text(
          title,
          style: theme.textTheme.bodyLarge!.copyWith(fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
