import "package:flutter/material.dart";
import "package:meal_muse/src/core/themes/colors.dart";

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final List<BottomNavigationBarItem>? items;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      indicatorColor: theme
          .navigationBarTheme
          .indicatorColor, // Subtle fill for selected item
      // unselectedItemColor: AppColors.mutedText,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_rounded), label: "Home"),
        NavigationDestination(
          icon: Icon(Icons.search_rounded),
          label: "Search",
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_today_rounded),
          label: "Schedule",
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline_rounded),
          label: "Saved",
        ),
      ],
    );
  }
}
