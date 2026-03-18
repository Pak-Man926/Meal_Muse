import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/schedulepage/data/date_container_widget.dart";

import "../../../core/themes/text_styles.dart";
import "../../../widgets/items_widget.dart";

class SchedulePageView extends StatelessWidget {
  const SchedulePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule", style: AppTextStyles.headingsText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Text("This Week", style: AppTextStyles.subHeadingsText),
            // ),
            // mediumSpaceSize,
            // ItemsWidget(
            //   image: Image.asset("assets/Chicken-stir-fry-V1.jpg"),
            //   heading: "Chicken Stir Fry",
            //   subHeading: "30 mins | 4 servings",
            // ),
            // mediumSpaceSize,
            // ItemsWidget(
            //   image: Image.asset("assets/Fluffy-Pancakes-Featured.jpg"),
            //   heading: "Fluffy Pancakes",
            //   subHeading: "20 mins | 4 servings",
            // ),
            // mediumSpaceSize,
            // ItemsWidget(
            //   image: Image.asset("assets/Pasta-Carbonara-Recipe-1.jpg"),
            //   heading: "Pasta Carbonara",
            //   subHeading: "25 mins | 4 servings",
            // ),
            // mediumSpaceSize,
            // ItemsWidget(
            //   image: Image.asset("assets/vegetable-curry-recipe.jpg"),
            //   heading: "Vegetable Curry",
            //   subHeading: "30 mins | 4 servings",
            // ),
            // mediumSpaceSize,
            // ItemsWidget(
            //   image: Image.asset(
            //     "assets/201005-r-xl-grilled-chicken-tacos-2000-63b2b629eace4d71a7ee63529e252c38.jpg",
            //   ),
            //   heading: "Chicken Tacos",
            //   subHeading: "48 mins | 4 servings",
            // ),
            // mediumSpaceSize,
            // ItemsWidget(
            //   image: Image.asset(
            //     "assets/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2007__04__honey-glazed-roast-chicken-horiz-a-1800-2057270028084ff2bdb54fcb0f2d3227.jpg",
            //   ),
            //   heading: "Honey Glazed Roast Chicken",
            //   subHeading: "1 hour | 4 servings",
            // ),
            // mediumSpaceSize,
            // ItemsWidget(
            //   image: Image.asset(
            //     "assets/pan-fried-salmon-featured-new.jpg",
            //   ),
            //   heading: "Pan-Fried Salmon",
            //   subHeading: "20 mins | 4 servings",
            // ),
            Text(
              "${DateTime.now().month}  ${DateTime.now().year}",
              style: AppTextStyles.bodyText,
            ),
            mediumSpaceSize,
            DatePickerWidget(day: "${DateTime.now().weekday - 2}", date: DateTime.now().day - 2),
          ],
        ),
      ),
    );
  }
}
