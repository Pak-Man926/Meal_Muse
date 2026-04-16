import "package:flutter/material.dart";

import "../../core/themes/colors.dart";
import "../../core/themes/text_styles.dart";

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = AppColors.bone,
    this.icon,
  });

  const CustomButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.color = AppColors.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
              style: AppTextStyles.bodyText.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
