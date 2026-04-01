import 'package:flutter_riverpod/flutter_riverpod.dart';

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
