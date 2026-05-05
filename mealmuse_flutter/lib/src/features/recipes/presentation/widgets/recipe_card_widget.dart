import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";

import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

class RecipeCardWidget extends StatelessWidget {
  final Image? image;
  final String heading;
  final String subHeading;
  final Function()? onTap;

  const RecipeCardWidget({
    super.key,
    required this.image,
    required this.heading,
    required this.subHeading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialButton(
      onPressed: onTap,
      hoverColor: theme.colorScheme.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              image: DecorationImage(
                image: image!
                    .image, // ?? AssetImage("assets/Chicken-stir-fry-V1.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            children: [
              Text(
                heading,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              smallSpaceSize,
              Text(
                subHeading,
                style: theme.textTheme.labelMedium!.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
