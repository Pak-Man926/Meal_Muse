import 'package:flutter/material.dart';
import 'package:meal_muse/src/core/themes/colors.dart';
import 'package:meal_muse/src/core/themes/text_styles.dart';

final ThemeData saffronTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.surface,

  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    surface: AppColors.surface,
    onSurface: AppColors.charcoal,
    onSurfaceVariant: AppColors.mutedText,
    surfaceContainerLow: AppColors.bone, // Crucial for Search Bars/Cards
  ),

  // Implementing the "No-Line" Rule for Inputs
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.bone,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // rounded-lg
      borderSide: BorderSide.none, // No-line rule
    ),
  ),

  textTheme: TextTheme(
    headlineMedium: AppTextStyles.sectionHeader,
    titleLarge: AppTextStyles.pageTitle,
    bodyLarge: AppTextStyles.bodyText,
    labelMedium: AppTextStyles.labelMuted,
  ),

  // Implementing the "Fill-Shift" Bottom Nav
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent, // We'll use Glassmorphism in the UI
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.mutedText,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
);
