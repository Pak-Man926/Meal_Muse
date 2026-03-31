import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

import "../../../core/themes/colors.dart";

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: AppTextStyles.headingsText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text("Preferences", style: AppTextStyles.subHeadingsText),
            mediumSpaceSize,
            ListTile(
              title: Text("Units of Measurements"),
              subtitle: Text("Metrics"),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
                activeColor: AppColors.primary,
              ),
            ),
            smallSpaceSize,
            ListTile(
              title: Text("Dietary Restrictions"),
              trailing: Icon(Icons.chevron_right),
            ),
            smallSpaceSize,
            ListTile(
              title: Text("App Theme"),
              subtitle: Text("Light"),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
                activeColor: AppColors.primary,
              ),
            ),
            smallSpaceSize,
            ListTile(
              title: Text("Notifications"),
              subtitle: Text("Off"),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
                activeColor: AppColors.primary,
              ),
            ),
            mediumSpaceSize,
            Text("Support", style: AppTextStyles.subHeadingsText),
            smallSpaceSize,
            ListTile(
              title: Text("Help & Support"),
              trailing: Icon(Icons.chevron_right),
            ),
            smallSpaceSize,
            ListTile(title: Text("About"), trailing: Icon(Icons.chevron_right)),
          ],
        ),
      ),
    );
  }
}
