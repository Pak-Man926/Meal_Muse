import "package:flutter/material.dart";
import "package:meal_muse/src/core/themes/colors.dart";

class ContainerWidget extends StatelessWidget {
  final String label;
  final Color? backgroundColor;

  const ContainerWidget({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.bone,
  });

  const ContainerWidget.extended({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      //alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }
}
