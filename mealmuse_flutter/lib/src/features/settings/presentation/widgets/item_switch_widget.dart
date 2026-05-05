import "package:flutter/material.dart";

import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class ItemSwitchWidget extends StatelessWidget {
  final String title;
  final Icon? icon;
  final bool value;
  final Function(bool) onChanged;

  const ItemSwitchWidget({
    super.key,
    required this.title,
    this.icon,
    this.value = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SwitchListTile(
      //title: Text(title, style: AppTextStyles.bodyText),
      title: Text(title),
      value: value,
      onChanged: (newValue) {
        onChanged(newValue);
      },
      controlAffinity: ListTileControlAffinity.trailing,
      secondary: icon,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      hoverColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.1),
      //thumbColor: WidgetStatePropertyAll(AppColors.mutedText.withOpacity(0.5)),
      //trackColor: WidgetStatePropertyAll(AppColors.mutedText.withOpacity(0.1)),
      trackOutlineColor: WidgetStatePropertyAll(
        theme.colorScheme.onSurface.withOpacity(0.2),
      ),
    );
  }
}
