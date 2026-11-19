import "package:material_ui/material_ui.dart";
import 'package:flutter_riverpod/legacy.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode?>((_) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<ThemeMode?> {
  ThemeProvider() : super(ThemeMode.system);

  void changeTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
  }
}
