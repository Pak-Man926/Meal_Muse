import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meal_muse/core/constants/constants.dart';

import '../../../core/themes/text_styles.dart';
import '../controllers/settingspage_controller.dart';

class SettingspageView extends GetView<SettingspageController> {
  const SettingspageView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back,
            icon: Icon(Icons.arrow_back_rounded),
            iconSize: 24,
            color: theme.colorScheme.onSurface,
          ),
          centerTitle: true,
          title: Text("Settings", style: AppTextStyles.headingsText),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Preferences", style: AppTextStyles.subHeadingsText),
              tinySpaceSize,
            ],
          ),
        ));
  }
}
