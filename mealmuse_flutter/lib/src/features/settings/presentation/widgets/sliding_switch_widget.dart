import "package:flutter/material.dart";

class SlidingSwitchWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function()? onTap;

  const SlidingSwitchWidget({
    super.key,
    required this.label,
    this.isSelected = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? theme
                      .colorScheme
                      .surface // Use the lifted surface color
                : theme.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(18),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: theme.colorScheme.onSurface.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: isSelected
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
