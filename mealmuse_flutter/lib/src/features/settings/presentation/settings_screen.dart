import "package:flutter/material.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";

import "../../../core/themes/colors.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: AppTextStyles.pageTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              height: 30,
              width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              //color: AppColors.primary.withOpacity(0.1),
            ),
            child: Switch(
              value: false,
              onChanged: (value) {},
              activeColor: AppColors.primary.withOpacity(0.1),
              
            ),

            ),
            // Text("Preferences", style: AppTextStyles.sectionHeader),
            // mediumSpaceSize,
            // ListTile(
            //   title: Text("Units of Measurements"),
            //   subtitle: Text("Metrics"),
            //   trailing: Switch(
            //     value: false,
            //     onChanged: (value) {},
            //     activeColor: AppColors.primary,
            //   ),
            // ),
            // smallSpaceSize,
            // ListTile(
            //   title: Text("Dietary Restrictions"),
            //   trailing: Icon(Icons.chevron_right),
            // ),
            // smallSpaceSize,
            // ListTile(
            //   title: Text("App Theme"),
            //   subtitle: Text("Light"),
            //   trailing: Switch(
            //     value: false,
            //     onChanged: (value) {},
            //     activeColor: AppColors.primary,
            //   ),
            // ),
            // smallSpaceSize,
            // ListTile(
            //   title: Text("Notifications"),
            //   subtitle: Text("Off"),
            //   trailing: Switch(
            //     value: false,
            //     onChanged: (value) {},
            //     activeColor: AppColors.primary,
            //   ),
            // ),
            // mediumSpaceSize,
            // Text("Support", style: AppTextStyles.sectionHeader),
            // smallSpaceSize,
            // ListTile(
            //   title: Text("Help & Support"),
            //   trailing: Icon(Icons.chevron_right),
            // ),
            // smallSpaceSize,
            // ListTile(title: Text("About"), trailing: Icon(Icons.chevron_right)),
          ],
        ),
      ),
    );
  }
}
