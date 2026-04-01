import "package:flutter/material.dart";
import "package:meal_muse/src/core/routes/routes.dart";
import "package:meal_muse/src/core/themes/theme.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: saffronTheme,
        //darkTheme: darkTheme,
        //themeMode: ThemeMode.system,
      ),
    );
  }
}
