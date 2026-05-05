import 'package:flutter/material.dart';
import 'package:meal_muse/src/core/themes/colors.dart';
import 'package:meal_muse/src/core/themes/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class Theme {
  static final saffronLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: LightAppColors.primary,
    scaffoldBackgroundColor: LightAppColors.surface,
    dividerColor: LightAppColors.glassBorder,

    colorScheme: const ColorScheme.light(
      primary: LightAppColors.primary,
      surface: LightAppColors.surface,
      onSurface: LightAppColors.charcoal,
      onSurfaceVariant: LightAppColors.mutedText,
      surfaceContainerLow: LightAppColors.bone,
      surfaceContainerLowest:
          LightAppColors.glassBorder, // Crucial for Search Bars/Cards
    ),

    // Implementing the "No-Line" Rule for Inputs
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LightAppColors.bone,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // rounded-lg
        borderSide: BorderSide.none, // No-line rule
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: LightAppTextStyles.sectionHeader,
      titleLarge: LightAppTextStyles.pageTitle,
      bodyLarge: LightAppTextStyles.bodyText,
      labelMedium: LightAppTextStyles.labelMuted,
    ),

    // Implementing the "Fill-Shift" Bottom Nav
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent, // We'll use Glassmorphism in the UI
      indicatorColor: LightAppColors.primary.withOpacity(0.2),
    ),
  );

  static final saffronDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: DarkAppColors.primary,
    scaffoldBackgroundColor: DarkAppColors.surface,
    dividerColor: DarkAppColors.glassBorder,

    colorScheme: const ColorScheme.dark(
      primary: DarkAppColors.primary,
      surface: DarkAppColors.surface,
      onSurface: DarkAppColors.onSurface,
      onSurfaceVariant: DarkAppColors.onSurfaceVariant,
      surfaceContainerLow: DarkAppColors.containerLow,
      surfaceContainerLowest:
          DarkAppColors.containerLowest, // Crucial for Search Bars/Cards
    ),

    // Implementing the "No-Line" Rule for Inputs
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkAppColors.outline,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // rounded-lg
        borderSide: BorderSide.none, // No-line rule
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: DarkAppTextStyles.sectionHeader,
      titleLarge: DarkAppTextStyles.pageTitle,
      bodyLarge: DarkAppTextStyles.bodyText,
      labelMedium: DarkAppTextStyles.labelMuted,
    ),

    // Implementing the "Fill-Shift" Bottom Nav
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent, // We'll use Glassmorphism in the UI
      indicatorColor: DarkAppColors.primary.withOpacity(0.2),
    ),
  );
}
