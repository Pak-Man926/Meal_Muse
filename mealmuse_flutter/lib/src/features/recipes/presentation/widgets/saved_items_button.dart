import "package:flutter/material.dart";
import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class ViewItemsButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Color? color;

  const ViewItemsButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color = const Color.fromARGB(255, 200, 199, 199),
  });

  const ViewItemsButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedColor = color ?? theme.colorScheme.primary;

    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
