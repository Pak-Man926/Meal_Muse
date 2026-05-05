import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:meal_muse/src/features/dashboard/presentation/widgets/navigation_bar.dart";
import "package:meal_muse/src/features/home/presentation/screens/home_screen.dart";
import "package:meal_muse/src/features/saved/presentation/screens/saved_screen.dart";
import "package:meal_muse/src/features/schedule/presentation/screens/schedule_screen.dart";
import "package:meal_muse/src/features/search/presentation/screens/search_screen.dart";
import '../controllers/dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  DashboardScreen({super.key});

  final List<Widget> pages = const [
    HomeScreen(),
    SearchScreen(),
    ScheduleScreen(),
    SavedScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      body: SafeArea(top: false, bottom: true, child: pages[currentIndex]),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).setIndex(index);
        },
      ),
    );
  }
}
