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
    return Scaffold(
      appBar: AppBar(
        title: Text("About", style: AppTextStyles.pageTitle),
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
                  style: AppTextStyles.labelMuted,
                ),
                smallSpaceSize,
                Text(
                  " © $currentYear Meal Muse. All rights reserved.",
                  style: AppTextStyles.labelMuted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
