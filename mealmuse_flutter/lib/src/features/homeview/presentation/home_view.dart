import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../data/bottom_navigation_bar.dart";
import "../../homepage/presentation/home_page.dart";
import "../../savedpage/presentation/saved_view.dart";
import "../../schedulepage/presentation/schedule_view.dart";
import "../../searchpage/presentation/search_view.dart";
import "../domain/home_view_provider.dart";

class HomeView extends ConsumerWidget {
  HomeView({super.key});

  final List<Widget> pages = const [
    HomePageView(),
    SearchPageView(),
    SchedulePageView(),
    SavedPageView(),
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
