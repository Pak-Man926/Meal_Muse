import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";
import "package:go_router/go_router.dart";
import "package:logger/logger.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/schedule/data/get_schedule_repository.dart";
import "package:meal_muse/src/features/schedule/presentation/widgets/date_container_widget.dart";
import "package:meal_muse/src/core/presentation/widgets/meal_card_widget.dart";
import 'package:meal_muse/src/core/presentation/widgets/container_widget.dart';
import 'package:intl/intl.dart';

final logger = Logger();
final weekdayProvider = StateProvider<String>((ref) {
  DateTime today = DateTime.now();
  String fullName = DateFormat("EEEE").format(today).toLowerCase();
  return fullName;
});

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedWeekDay = ref.watch(weekdayProvider);
    final recipeScheduleState = ref.watch(getScheduleProvider(selectedWeekDay));
    final theme = Theme.of(context);

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
    //String currentYear = today.year.toString();
    String currentDay = DateFormat("EEE").format(today);

    int daysSinceSunday = today.weekday % 7;
    DateTime startOfWeek = today.subtract(Duration(days: daysSinceSunday));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await ref.refresh(getScheduleProvider(selectedWeekDay).future);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 180.0,
              elevation: 0,
              title: Text("Meal Schedule", style: theme.textTheme.titleLarge),
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
                          //TODO: Ensure the tiles run from monday to sunday and change with dates but the schedule remains unless changed.
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          // Inside your ScheduleScreen ListView.builder
                          itemBuilder: (context, index) {
                            DateTime targetDate = startOfWeek.add(
                              Duration(days: index),
                            );

                            String shortDayName =
                                weekdayNames[targetDate.weekday - 1];
                            String fullDayName = DateFormat(
                              "EEEE",
                            ).format(targetDate).toLowerCase();

                            return DatePickerWidget(
                              day: shortDayName,
                              date: targetDate.day,
                              isActive: selectedWeekDay == fullDayName,
                              onTap: () {
                                // Update the state with the full lowercase day name for the API
                                ref.read(weekdayProvider.notifier).state =
                                    fullDayName;

                                logger.i("Date tapped: $fullDayName");
                              },
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
                      style: theme.textTheme.headlineMedium,
                    ),
                    ContainerWidget.extended(
                      label:
                          "${recipeScheduleState.value?.length ?? 0} Meals Planned",
                      backgroundColor: theme.colorScheme.primary.withOpacity(
                        0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return recipeScheduleState.when(
                  loading: () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) {
                    logger.e(
                      "Error fetching schedule",
                      error: error,
                      stackTrace: stack,
                    );
                    return const SliverToBoxAdapter(
                      child: Center(child: Text("Error fetching schedule.")),
                    );
                  },
                  data: (scheduleData) {
                    if (scheduleData.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text("No meals scheduled for this day."),
                        ),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          scheduleData.map((scheduleItem) {
                            final imagePath =
                                scheduleItem.recipe.images.isNotEmpty
                                ? scheduleItem.recipe.images.first
                                : '';
                            final fullImageUrl = imagePath.isNotEmpty
                                ? "$imageBaseUrl$imagePath"
                                : "https://via.placeholder.com/400";
                            return Column(
                              children: [
                                smallSpaceSize,
                                MealCardWidget(
                                  id: scheduleItem.recipeId,
                                  mealType: scheduleItem.mealType,
                                  meal: scheduleItem.recipe.name,
                                  prepTime: scheduleItem.recipe.totalTime,
                                  composition: 0,
                                  imageAddress: fullImageUrl,
                                  onTap: () {
                                    context.push(
                                      "/recipes/${scheduleItem.recipeId}",
                                    );
                                  },
                                ),
                                mediumSpaceSize,
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
