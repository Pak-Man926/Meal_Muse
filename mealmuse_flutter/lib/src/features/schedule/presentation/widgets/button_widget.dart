import "package:flutter/material.dart";

import "../../../../core/themes/colors.dart";
import "../../../../core/themes/text_styles.dart";

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = AppColors.bone,
  });

  const CustomButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.color = AppColors.primary,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: AppTextStyles.bodyText.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
