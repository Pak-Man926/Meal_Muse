import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "widgets/bottom_navigation_bar.dart";
import "../../home/presentation/home_screen.dart";
import "../../saved/presentation/saved_screen.dart";
import "../../schedule/presentation/schedule_screen.dart";
import "../../search/presentation/search_screen.dart";
import "dashboard_controller.dart";

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
