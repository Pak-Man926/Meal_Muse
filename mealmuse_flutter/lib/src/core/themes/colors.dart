import "package:flutter/material.dart";

class LightAppColors {
  static const Color primary = Color(0xFFEA2A33); // Saffron Red
  static const Color charcoal = Color(
    0xFF181111,
  ); // Main Text & Dark Backgrounds
  static const Color bone = Color(0xFFF8F6F6); // surface_container_low
  static const Color surface = Color(0xFFFFFFFF);
  static const Color mutedText = Color(0xFF886364); // on_surface_variant
  static const Color glassBorder = Color(0xFFF4F0F0); // For Bottom Nav border
}

class DarkAppColors {
  // Core Surfaces
  static const Color surface = Color(0xFF1F0F0E);
  static const Color surfaceBright = Color(0xFF493432);
  static const Color background = Color(0xFF1F0F0E);

  // Tonal Layering (Use these instead of elevation)
  static const Color containerLowest = Color(0xFF190A09);
  static const Color containerLow = Color(0xFF281716);
  static const Color container = Color(0xFF2D1B1A);
  static const Color containerHigh = Color(0xFF382524);
  static const Color containerHighest = Color(0xFF44302E);
  static const Color glassBorder = Color(0xFFF4F0F0);

  // Brand / Action Colors
  static const Color primary = Color(0xFFEA2A33);
  static const Color onPrimary = Color(0xFF68000A);
  static const Color primaryContainer = Color(0xFFFF5451);

  static const Color secondary = Color(0xFFC8C6C5);
  static const Color tertiary = Color(0xFFE9C176); // Muted Gold

  // Content Colors
  static const Color onSurface = Color(0xFFFCDBD8);
  static const Color onSurfaceVariant = Color(0xFFE6BDB9);
  static const Color outline = Color(0xFFAD8885);
  static const Color outlineVariant = Color(0xFF5D3F3D);
}
