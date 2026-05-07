import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";
import "package:go_router/go_router.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/utils/theme_provider.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/item_checkbox_widget.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/item_switch_widget.dart";
import "package:meal_muse/src/features/settings/presentation/widgets/sliding_switch_widget.dart";
import 'package:meal_muse/src/core/presentation/widgets/button_widget.dart';

final measurementProvider = StateProvider<bool>((ref) {
  return false;
});

class SettingsScreen extends ConsumerWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);
    //final measurementState = ref.read(measurementProvider.notifier).state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              //Text("Units of measurement", style: AppTextStyles.sectionHeader),
              Text("Units of measurement"),
              smallSpaceSize,
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                  ),
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    final isMetric = ref.watch(measurementProvider);
                    return Row(
                      children: [
                        SlidingSwitchWidget(
                          label: "Metric (g,ml)",
                          isSelected: isMetric == true,
                          onTap: () =>
                              ref.read(measurementProvider.notifier).state =
                                  true,
                        ),
                        smallSpaceSize,
                        SlidingSwitchWidget(
                          label: "Imperial (oz, lb)",
                          isSelected: isMetric == false,
                          onTap: () =>
                              ref.read(measurementProvider.notifier).state =
                                  false,
                        ),
                      ],
                    );
                  },
                ),
              ),
              mediumSpaceSize,
              Text(
                "Dietary Restrictions",
                style: theme.textTheme.headlineMedium,
              ),
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
              Text("App Theme", style: theme.textTheme.headlineMedium),
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
              Text("Notifications", style: theme.textTheme.headlineMedium),
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
              Text("Support", style: theme.textTheme.headlineMedium),
              smallSpaceSize,
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                title: Text(
                  "FAQs & Help Center",
                  style: theme.textTheme.bodyLarge,
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onTap: () {},
              ),
              Divider(thickness: 0.1),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                title: Text("About App", style: theme.textTheme.bodyLarge),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onTap: () => context.push("/about"),
              ),
              Divider(thickness: 0.1),
              ListTile(
                leading: Icon(
                  Icons.policy_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                title: Text("Privacy Policy", style: theme.textTheme.bodyLarge),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
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
