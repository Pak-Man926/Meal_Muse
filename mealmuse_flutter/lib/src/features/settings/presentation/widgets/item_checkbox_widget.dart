import "package:flutter/material.dart";

import "package:meal_muse/src/core/themes/colors.dart";

class ItemCheckBoxWidget extends StatelessWidget {
  final String title;
  final bool value;
  //final ValueChanged<bool> onChanged;

  const ItemCheckBoxWidget({
    super.key,
    required this.title,
    this.value = false,
    //this.onChanged,,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) {
        //onChanged?.call(newValue ?? false);
      },
      controlAffinity: ListTileControlAffinity.trailing,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      checkColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      hoverColor: AppColors.mutedText.withOpacity(0.1),
    );
  }
}
