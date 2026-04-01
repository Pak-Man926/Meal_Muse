import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";

class RecipeCardWidget extends StatelessWidget {
  final Image? image;
  final String heading;
  final String subHeading;

  const RecipeCardWidget({
    super.key,
    required this.image,
    required this.heading,
    required this.subHeading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image!
                  .image, // ?? AssetImage("assets/Chicken-stir-fry-V1.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Text(
              heading,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            smallSpaceSize,
            Text(
              subHeading,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
