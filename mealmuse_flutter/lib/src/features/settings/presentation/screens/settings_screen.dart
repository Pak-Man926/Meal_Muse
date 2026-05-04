import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "package:meal_muse/src/core/utils/theme_provider.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/item_checkbox_widget.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/item_switch_widget.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/sliding_switch_widget.dart";

import "package:meal_muse/src/core/themes/colors.dart";
import 'package:meal_muse/src/core/presentation/widgets/button_widget.dart';

class SettingsScreen extends ConsumerWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);

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
              Consumer(
                builder: (context, ref, child) {
                  return ItemSwitchWidget(
                    title: themeModeState == ThemeMode.dark
                        ? "Dark Mode"
                        : "Light Mode",
                    icon: Icon(
                      themeModeState == ThemeMode.dark
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                    value: themeModeState == ThemeMode.dark,
                    onChanged: (value) =>
                        ref.read(themeProvider.notifier).changeTheme(value),
                  );
                },
              ),
              mediumSpaceSize,
              Text("Notifications", style: AppTextStyles.sectionHeader),
              smallSpaceSize,
              ItemSwitchWidget(
                title: "Push Notifications",
                value: true,
                onChanged: (value) {
                  // Placeholder for notification toggle logic
                },
              ),
              Divider(thickness: 0.1),
              ItemSwitchWidget(
                title: "Recipe Recommendations",
                value: true,
                onChanged: (value) {
                  // Placeholder for notification toggle logic
                },
              ),
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
                onTap: () => context.push("/about"),
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
              largeSpaceSize,
              CustomButton.primary(text: 'Save', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
