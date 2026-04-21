import "package:flutter/material.dart";
import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class ContainerWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Color backgroundColor;
  final bool isActive;

  const ContainerWidget({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor = AppColors.bone,
    this.isActive = false,
  });

  const ContainerWidget.extended({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor = AppColors.primary,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      //alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? backgroundColor : AppColors.bone,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: AppTextStyles.bodyText.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
