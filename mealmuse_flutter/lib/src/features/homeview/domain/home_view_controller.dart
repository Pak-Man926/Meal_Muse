import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../homepage/presentation/home_page.dart';
import '../../savedpage/presentation/saved_view.dart';
import '../../schedulepage/presentation/schedule_view.dart';
import '../../searchpage/presentation/search_view.dart';

class BottomNavNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void setIndex(int index) {
    state = index;
  }
}

final bottomNavProvider = NotifierProvider<BottomNavNotifier, int>(() {
  return BottomNavNotifier();
});
