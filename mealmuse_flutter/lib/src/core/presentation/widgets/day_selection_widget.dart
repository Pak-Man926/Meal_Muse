import "package:flutter/material.dart";

class DaySelectionWidget extends StatelessWidget {
  final String selectedDay;
  final Function(String) onDaySelected;

  const DaySelectionWidget({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    return Center(
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          Text("Selected a day:", style: theme.textTheme.titleMedium),
          const SizedBox(height:8),
          Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: List<Widget>.generate(daysOfWeek.length, (index) {
              final day = daysOfWeek[index];
              final isSelected = day == selectedDay;
              return ChoiceChip(
                label: Text(day),
                selected: isSelected,
                onSelected: (_) => onDaySelected(day),
                selectedColor: theme.colorScheme.primary.withOpacity(0.7),
                backgroundColor: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelStyle: TextStyle(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              );
            }),
          ),
        ]
      ),
    );
  }
}
