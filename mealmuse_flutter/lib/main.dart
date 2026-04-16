import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_muse/src/app.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:meal_muse/src/core/constants/constants.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(ProviderScope(child: const MyApp()));
}
