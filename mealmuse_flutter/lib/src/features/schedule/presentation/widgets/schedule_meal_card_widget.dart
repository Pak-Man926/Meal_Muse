import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "button_widget.dart";

class ScheduleCardWidget extends StatelessWidget {
  final String mealType;
  final String meal;
  final int prepTime;
  final int composition;
  final String imageAddress;

  const ScheduleCardWidget({
    super.key,
    required this.mealType,
    required this.meal,
    required this.prepTime,
    required this.composition,
    required this.imageAddress,
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
                        style: AppTextStyles.subHeadingsText,
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
                    const Icon(Icons.timer, size: 20, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      "$prepTime min",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.local_fire_department,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$composition kcal",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                smallSpaceSize,
                CustomButton.primary(text: "View Recipe"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
