import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/features/schedulepage/data/date_container_widget.dart";
import "package:meal_muse/src/features/schedulepage/data/schedule_meal_card_widget.dart";
import "package:meal_muse/src/features/searchpage/data/container_widget.dart";
import "../../../core/themes/text_styles.dart";
import 'package:intl/intl.dart';

class SchedulePageView extends StatelessWidget {
  const SchedulePageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Moved the date logic inside the build method so it updates correctly
    // if the user leaves the app open overnight.
    DateTime today = DateTime.now();
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    const List<String> weekdayNames = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    String currentMonth = monthNames[today.month - 1];
    String currentYear = today.year.toString();
    String currentDay = DateFormat("EEE").format(today);

    return Scaffold(
      // We remove the standard AppBar and body Column entirely,
      // replacing them with a CustomScrollView.
      body: CustomScrollView(
        slivers: [
          // 1. The Collapsing Header (SliverAppBar)
          SliverAppBar(
            pinned: true, // Keeps the "Schedule" title visible at all times
            expandedHeight: 160.0, // The height when fully pulled down
            elevation: 0,
            title: Text("Schedule", style: AppTextStyles.headingsText),
            centerTitle: true,
            // FlexibleSpaceBar is what handles the shrinking/collapsing animation
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                // We add top padding to push the calendar below the pinned AppBar title
                padding: const EdgeInsets.only(
                  top: kToolbarHeight + 20,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                          110, // Slightly reduced to fit nicely in the header
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          DateTime targetDate = today.add(
                            Duration(days: index),
                          );
                          String dayName = weekdayNames[targetDate.weekday - 1];
                          return DatePickerWidget(
                            day: dayName,
                            date: targetDate.day,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 2. The Daily Header Row (Scrolls away normally)
          // SliverToBoxAdapter lets us drop standard Flutter widgets into a scroll view
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$currentDay, $currentMonth ${today.day}",
                    style: AppTextStyles.subHeadingsText,
                  ),
                  ContainerWidget.extended(label: "3 Meals Planned"),
                ],
              ),
            ),
          ),

          // 3. The List of Meals
          // SliverList is highly optimized for scrolling long columns of data
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                smallSpaceSize,
                ScheduleCardWidget(
                  mealType: "Breakfast",
                  meal: "Poached Eggs & Salad",
                  prepTime: 15,
                  composition: 320,
                  imageAddress: "assets/avocado-6b1cf76.jpg",
                ),
                mediumSpaceSize,
                ScheduleCardWidget(
                  mealType: "Lunch",
                  meal: "Miso Glazed Salmon Salad",
                  prepTime: 25,
                  composition: 450,
                  imageAddress:
                      "assets/feb20_salmon-salad-with-sesame-miso-dressing-taste-157324-1.jpg",
                ),
                mediumSpaceSize,
                ScheduleCardWidget(
                  mealType: "Dinner",
                  meal: "Mediterranean Paste",
                  prepTime: 35,
                  composition: 580,
                  imageAddress: "assets/mediterranean-pasta-sq-1.jpg",
                ),
                largeSpaceSize,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
