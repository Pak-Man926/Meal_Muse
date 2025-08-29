import "package:flutter/material.dart";

import "colors.dart";
import "text_styles.dart";

final ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  colorScheme:const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.backgroundLight,
    onSurface: AppColors.textPrimary,
  ),

  textTheme: TextTheme(
    displayLarge: AppTextStyles.headingsText,
    displayMedium: AppTextStyles.subHeadingsText,
    displaySmall: AppTextStyles.bodyText,
  ),
);

