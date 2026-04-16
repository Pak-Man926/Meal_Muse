import "package:flutter/material.dart";

import "../../../../core/themes/colors.dart";
import "../../../../core/themes/text_styles.dart";

class ItemSwitchWidget extends StatelessWidget {
  final String title;
  final Icon? icon;
  final bool value;

  const ItemSwitchWidget({
    super.key,
    required this.title,
    this.icon,
    this.value = false,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: AppTextStyles.bodyText),
      value: value,
      onChanged: (newValue) {
        // Handle slider change
      },
      controlAffinity: ListTileControlAffinity.trailing,
      secondary: icon,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      hoverColor: AppColors.mutedText.withOpacity(0.1),
      //thumbColor: WidgetStatePropertyAll(AppColors.mutedText.withOpacity(0.5)),
      //trackColor: WidgetStatePropertyAll(AppColors.mutedText.withOpacity(0.1)),
      trackOutlineColor: WidgetStatePropertyAll(
        AppColors.charcoal.withOpacity(0.2),
      ),
    );
  }
}
