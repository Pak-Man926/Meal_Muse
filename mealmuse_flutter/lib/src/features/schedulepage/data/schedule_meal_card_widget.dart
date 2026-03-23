import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "package:meal_muse/src/features/schedulepage/data/button_widget.dart";

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
      elevation: 3, // Adds a subtle shadow under the card
      clipBehavior: Clip
          .antiAlias, // Magically clips the image to fit the Card's rounded corners
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. The Image Section
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Image.asset(
              imageAddress,
              fit: BoxFit
                  .cover, // 'cover' crops the image cleanly without distorting it
            ),
          ),

          // 2. The Text & Details Section
          Padding(
            padding: const EdgeInsets.all(
              12.0,
            ), // Gives your text some breathing room from the edges
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The Title and Favorite Button
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Pushes title left, icon right
                  children: [
                    Expanded(
                      // Prevents super long recipe names from pushing the icon off the screen
                      child: Text(
                        meal,
                        style: AppTextStyles.subHeadingsText,
                        maxLines: 1, // Keeps the title to one line
                        overflow: TextOverflow
                            .ellipsis, // Adds "..." if the title is too long
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Add favorite logic here
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                      ), // Usually outlined until selected
                      color: Colors.red,
                    ),
                  ],
                ),
                smallSpaceSize,

                // The Icons and Data (Prep time & Composition)
                Row(
                  children: [
                    // Prep Time
                    const Icon(Icons.timer, size: 20, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      "$prepTime min",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(width: 20), // Space between the two stats
                    // Composition / Calories
                    const Icon(
                      Icons.local_fire_department,
                      size: 20,
                      color: Colors.grey,
                    ), // Fireplace is fine, but local_fire_department is standard for calories!
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
