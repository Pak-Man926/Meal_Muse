import "package:flutter/material.dart";

import "package:meal_muse/src/core/themes/colors.dart";

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = ThemeMode.light == true
        ? LightAppColors.bone
        : DarkAppColors.containerLow,
    this.icon,
  });

  const CustomButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.color = ThemeMode.light == true
        ? LightAppColors.primary
        : DarkAppColors.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),

            const SizedBox(width: 5), // Space between icon and text

            Text(
              text,
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
