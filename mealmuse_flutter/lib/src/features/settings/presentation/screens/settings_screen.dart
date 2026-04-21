import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/item_checkbox_widget.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/item_switch_widget.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/sliding_switch_widget.dart";
import 'package:intl/intl.dart';

import "package:meal_muse/src/core/themes/colors.dart";
import 'package:meal_muse/src/core/presentation/widgets/button_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  DateTime currentDate = DateTime.now();

  String get currentYear => currentDate.year.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: AppTextStyles.pageTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text("Units of measurement", style: AppTextStyles.sectionHeader),
              smallSpaceSize,
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: AppColors.bone,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.charcoal.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    SlidingSwitchWidget(
                      label: "Metric (g,ml)",
                      isSelected: true,
                      onTap: () {},
                    ),
                    smallSpaceSize,
                    SlidingSwitchWidget(
                      label: "Imperial (oz, lb)",
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              mediumSpaceSize,
              Text("Dietary Restrictions", style: AppTextStyles.sectionHeader),
              smallSpaceSize,
              ItemCheckBoxWidget(title: "Vegetarian"),
              Divider(thickness: 0.1),
              ItemCheckBoxWidget(title: "Vegan"),
              Divider(thickness: 0.1),
              ItemCheckBoxWidget(title: "Gluten-Free"),
              Divider(thickness: 0.1),
              ItemCheckBoxWidget(title: "Dairy-Free"),
              Divider(thickness: 0.1),
              mediumSpaceSize,
              Text("App Theme", style: AppTextStyles.sectionHeader),
              smallSpaceSize,
              ItemSwitchWidget(
                title: "Light Mode",
                icon: Icon(Icons.light_mode_outlined),
              ),
              mediumSpaceSize,
              Text("Notifications", style: AppTextStyles.sectionHeader),
              smallSpaceSize,
              ItemSwitchWidget(title: "Push Notifications", value: true),
              Divider(thickness: 0.1),
              ItemSwitchWidget(title: "Recipe Recommendations", value: true),
              mediumSpaceSize,
              Text("Support", style: AppTextStyles.sectionHeader),
              smallSpaceSize,
              ListTile(
                leading: Icon(Icons.help, color: AppColors.mutedText),
                title: Text(
                  "FAQs & Help Center",
                  style: AppTextStyles.bodyText,
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.mutedText,
                ),
                onTap: () {},
              ),
              Divider(thickness: 0.1),
              ListTile(
                leading: Icon(Icons.info, color: AppColors.mutedText),
                title: Text("About App", style: AppTextStyles.bodyText),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.mutedText,
                ),
                onTap: () {},
              ),
              Divider(thickness: 0.1),
              ListTile(
                leading: Icon(Icons.policy_rounded, color: AppColors.mutedText),
                title: Text("Privacy Policy", style: AppTextStyles.bodyText),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.mutedText,
                ),
                onTap: () {},
              ),
              mediumSpaceSize,
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
              largeSpaceSize,
              CustomButton.primary(text: 'Save', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
