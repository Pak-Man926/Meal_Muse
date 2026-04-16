import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "../../../../core/themes/colors.dart";
import "../../../../models/widgets/button_widget.dart";

class ScheduleCardWidget extends StatelessWidget {
  final String mealType;
  final String meal;
  final int prepTime;
  final int composition;
  final String imageAddress;
  final Function()? onTap;

  const ScheduleCardWidget({
    super.key,
    required this.mealType,
    required this.meal,
    required this.prepTime,
    required this.composition,
    required this.imageAddress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: Image.asset(imageAddress, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        meal,
                        style: AppTextStyles.sectionHeader,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Add favorite logic here
                      },
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.red,
                    ),
                  ],
                ),
                smallSpaceSize,
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 20,
                      color: AppColors.mutedText,
                    ),
                    const SizedBox(width: 4),
                    Text("$prepTime min", style: AppTextStyles.labelMuted),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.local_fire_department,
                      size: 20,
                      color: AppColors.mutedText,
                    ),
                    const SizedBox(width: 4),
                    Text("$composition kcal", style: AppTextStyles.labelMuted),
                  ],
                ),
                smallSpaceSize,
                CustomButton.primary(text: "View Recipe", onPressed: onTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
