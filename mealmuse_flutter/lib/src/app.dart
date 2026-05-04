import "package:flutter/material.dart" hide Theme;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/core/routes/routes.dart";
import "package:meal_muse/src/core/themes/theme.dart";

import "core/utils/theme_provider.dart";

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      bottom: true,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: Theme.saffronLightTheme,
        darkTheme: Theme.saffronDarkTheme,
        themeMode: ref.watch(themeProvider),
      ),
    );
  }
}
