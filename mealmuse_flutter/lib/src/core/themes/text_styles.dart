import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:meal_muse/src/core/themes/colors.dart";

class LightAppTextStyles {
  // 22px Section Headers (Bold)
  static final TextStyle pageTitle = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.33, // -0.015em
    color: LightAppColors.charcoal,
  );

  // 18px Primary Page Titles
  static final TextStyle sectionHeader = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.27,
    color: LightAppColors.charcoal,
  );

  // 16px Body Text
  static final TextStyle bodyText = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: LightAppColors.charcoal,
  );

  // 14px Metadata/Labels
  static final TextStyle labelMuted = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    color: LightAppColors.mutedText,
  );
}

class DarkAppTextStyles {
  static final TextStyle pageTitle = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.33, // -0.015em
    color: DarkAppColors.onSurface,
  );

  // 18px Primary Page Titles
  static final TextStyle sectionHeader = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.27,
    color: DarkAppColors.onSurface,
  );

  // 16px Body Text
  static final TextStyle bodyText = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: DarkAppColors.onSurface,
  );

  // 14px Metadata/Labels
  static final TextStyle labelMuted = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    color: DarkAppColors.outlineVariant,
  );
}
