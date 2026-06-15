import "package:flutter/material.dart" hide Theme;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/core/presentation/widgets/network_error_widget.dart";
import "package:meal_muse/src/core/routes/routes.dart";
import "package:meal_muse/src/core/themes/theme.dart";

import "core/network/network_provider.dart";
import "core/themes/providers/theme_provider.dart";

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
        builder: (context, child) {
          return GlobalNetworkObserver(child: child!);
        },
      ),
    );
  }
}

class GlobalNetworkObserver extends ConsumerWidget {
  final Widget child;

  const GlobalNetworkObserver({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityStatusProvider);
    final isDisconnected =
        connectivity is AsyncData &&
        connectivity.value == ConnectivityStatus.isDisconnected;

    return Stack(
      children: [
        child,
        if (isDisconnected) const Positioned.fill(child: NetworkErrorWidget()),
      ],
    );
  }
}
