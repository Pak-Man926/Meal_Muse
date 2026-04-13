import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "widgets/date_container_widget.dart";
import "widgets/schedule_meal_card_widget.dart";
import "../../search/presentation/widgets/container_widget.dart";
import "../../../core/themes/text_styles.dart";
import 'package:intl/intl.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    int daysSinceSunday = today.weekday % 7;
    DateTime startOfWeek = today.subtract(Duration(days: daysSinceSunday));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150.0,
            elevation: 0,
            title: Text("Meal Schedule", style: AppTextStyles.pageTitle),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(
                  top: kToolbarHeight + 20,
                  left: 10,
                  right: 10,
                  //bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        //TODO: Ensure the tiles run from monday to sunday and change with dates but the schedule remains.
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        // Inside your ScheduleScreen ListView.builder
                        itemBuilder: (context, index) {
                          DateTime targetDate = startOfWeek.add(
                            Duration(days: index),
                          );

                          // Logic to check if targetDate is the same day as DateTime.now()
                          bool isToday =
                              targetDate.year == today.year &&
                              targetDate.month == today.month &&
                              targetDate.day == today.day;

                          String dayName = weekdayNames[targetDate.weekday - 1];

                          return DatePickerWidget(
                            day: dayName,
                            date: targetDate.day,
                            isActive:
                                isToday, // Pass the comparison result here
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$currentDay, $currentMonth ${today.day}",
                    style: AppTextStyles.sectionHeader,
                  ),
                  ContainerWidget.extended(label: "3 Meals Planned"),
                ],
              ),
            ),
          ),
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
                  onTap: () {},
                ),
                mediumSpaceSize,
                ScheduleCardWidget(
                  mealType: "Lunch",
                  meal: "Miso Glazed Salmon Salad",
                  prepTime: 25,
                  composition: 450,
                  imageAddress:
                      "assets/feb20_salmon-salad-with-sesame-miso-dressing-taste-157324-1.jpg",
                  onTap: () {},
                ),
                mediumSpaceSize,
                ScheduleCardWidget(
                  mealType: "Dinner",
                  meal: "Mediterranean Paste",
                  prepTime: 35,
                  composition: 580,
                  imageAddress: "assets/mediterranean-pasta-sq-1.jpg",
                  onTap: () {},
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
