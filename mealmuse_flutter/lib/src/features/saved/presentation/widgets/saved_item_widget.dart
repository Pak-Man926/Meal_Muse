import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

import "../../../../core/themes/colors.dart";

class SavedItemWidget extends StatelessWidget {
  final String? mealType;
  final String meal;
  final int prepTime;
  final int composition;
  final String imageAddress;

  const SavedItemWidget({
    super.key,
    this.mealType,
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
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset(
                  imageAddress,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Space from image edges
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                      onPressed: () {
                        // TODO: Add favorite logic here
                      },
                      icon: const Icon(Icons.favorite_border, size: 20),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                // Title Row
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        meal,
                        style: AppTextStyles.sectionHeader,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                smallSpaceSize,
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 18,
                      color: AppColors.mutedText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$prepTime min",
                      style: AppTextStyles.labelMuted.copyWith(fontSize: 10),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.local_fire_department,
                      size: 18,
                      color: AppColors.mutedText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$composition kcal",
                      style: AppTextStyles.labelMuted.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
