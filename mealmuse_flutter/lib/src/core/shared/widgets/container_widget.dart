import "package:flutter/material.dart";
import "../../themes/colors.dart";

class ContainerWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Color backgroundColor;
  final bool isActive;

  const ContainerWidget({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor = ThemeMode.light == true
        ? LightAppColors.bone
        : DarkAppColors.containerLow,
    this.isActive = false,
  });

  const ContainerWidget.extended({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor = ThemeMode.light == true
        ? LightAppColors.primary
        : DarkAppColors.primary,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      //alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive
            ? backgroundColor
            : theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: theme.textTheme.bodyLarge!.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
