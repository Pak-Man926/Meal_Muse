import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";

class CategoriesButton extends StatelessWidget {
  final IconData icon;
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
        InkWell(
          onTap: onPressed, 
          borderRadius: BorderRadius.circular(50), 
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: theme.colorScheme.surfaceContainerLow,
              child: Icon(
                icon, 
                size: 20, 
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        tinySpaceSize,
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