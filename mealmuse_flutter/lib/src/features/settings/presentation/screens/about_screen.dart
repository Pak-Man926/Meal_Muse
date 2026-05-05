import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/text_styles.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  DateTime currentDate = DateTime.now();

  String get currentYear => currentDate.year.toString();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("About", style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "$appName ${packageInfo.version} (${packageInfo.buildNumber})",
                  style: theme.textTheme.labelMedium,
                ),
                smallSpaceSize,
                Text(
                  " © $currentYear Meal Muse. All rights reserved.",
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
