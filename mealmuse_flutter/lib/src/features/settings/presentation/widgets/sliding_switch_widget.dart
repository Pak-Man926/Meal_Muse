import "package:flutter/material.dart";
import "package:meal_muse/src/core/themes/colors.dart";

import "package:meal_muse/src/core/themes/text_styles.dart";

class SlidingSwitchWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function()? onTap;

  const SlidingSwitchWidget({
    super.key,
    required this.label,
    this.isSelected = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.charcoal.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyText.copyWith(
              color: isSelected ? AppColors.charcoal : AppColors.mutedText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
