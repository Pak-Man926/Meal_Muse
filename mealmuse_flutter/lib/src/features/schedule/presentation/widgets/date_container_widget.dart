import 'package:flutter/material.dart';
import 'package:meal_muse/src/core/constants/constants.dart';

import 'package:meal_muse/src/core/themes/colors.dart';
import 'package:meal_muse/src/core/themes/text_styles.dart';

class DatePickerWidget extends StatelessWidget {
  final String day;
  final int date;
  final bool isActive; // Add this

  const DatePickerWidget({
    super.key,
    required this.day,
    required this.date,
    this.isActive = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
      child: Container(
        height: 120,
        width: 65, // Slightly narrowed for better fit
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // Toggle background color based on isActive
          color: isActive ? AppColors.primary : AppColors.bone,
          border: isActive ? null : Border.all(color: AppColors.glassBorder),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          // Use InkWell instead of FilledButton for cleaner styling
          onTap: () {},
          borderRadius: BorderRadius.circular(15),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                day,
                style: AppTextStyles.bodyText.copyWith(
                  color: isActive ? Colors.white : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              smallSpaceSize,
              Text(
                date.toString(),
                style: AppTextStyles.sectionHeader.copyWith(
                  color: isActive ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
