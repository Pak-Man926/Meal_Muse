import "package:double_tap_to_exit/double_tap_to_exit.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:meal_muse/src/features/dashboard/presentation/widgets/navigation_bar.dart";
import "package:meal_muse/src/features/home/presentation/screens/home_screen.dart";
import "package:meal_muse/src/features/saved/presentation/screens/saved_screen.dart";
import "package:meal_muse/src/features/schedule/presentation/screens/schedule_screen.dart";
import "package:meal_muse/src/features/search/presentation/screens/search_screen.dart";
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  final List<Widget> pages = const [
    HomeScreen(),
    SearchScreen(),
    ScheduleScreen(),
    SavedScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: DoubleTapToExit(
        snackBar: SnackBar(
          backgroundColor: theme.colorScheme.primary,
          content: Text(
            "Press back again to exit",
            style: theme.textTheme.labelSmall,
          ),
        ),
        child: SafeArea(top: false, bottom: true, child: pages[currentIndex]),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).setIndex(index);
        },
      ),
    );
  }
}
