import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/colors.dart";

import "../../../core/themes/text_styles.dart";

class DatePickerWidget extends StatelessWidget {
  final String day;
  final int date;

  const DatePickerWidget({super.key, required this.day, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 95,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: FilledButton(
          onPressed: () {},
          //style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(day),
              smallSpaceSize,
              Text(date.toString(), style: AppTextStyles.bodyText),
            ],
          ),
        ),
      ),
    );
  }
}
