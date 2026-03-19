import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/schedulepage/data/date_container_widget.dart";
import "package:meal_muse/src/features/searchpage/data/container_widget.dart";

import "../../../core/themes/text_styles.dart";
import "../../../widgets/items_widget.dart";
import 'package:intl/intl.dart';

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
          crossAxisAlignment: .start,
          children: [
            Text("$currentMonth $currentYear", style: AppTextStyles.bodyText),
            mediumSpaceSize,
            SizedBox(
              height: 130, // Adjust this to fit your DatePickerWidget
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  DateTime targetDate = today.add(Duration(days: index));
                  String dayName = weekdayNames[targetDate.weekday - 1];
                  return DatePickerWidget(
                    day: dayName,
                    date: targetDate.day, // Extracts just the number (e.g., 19)
                  );
                },
              ),
            ),
            smallSpaceSize,
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "$currentDay, $currentMonth ${today.day}",
                  style: AppTextStyles.subHeadingsText,
                ),
                // Container(
                //   height: 30,
                //   decoration: BoxDecoration(
                //     border: Border.all(),
                //     borderRadius: BorderRadius.circular(20),
                //     shape: BoxShape.rectangle,
                //      ),
                //      child: Text("3 Meals Planned", style: AppTextStyles.bodyText),
                // ),
                ContainerWidget.extended(label: "3 Meals Planned"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

DateTime today = DateTime.now();

String currentMonth = monthNames[today.month - 1];
String currentYear = today.year.toString();
String currentDay = DateFormat("EEE").format(today);
