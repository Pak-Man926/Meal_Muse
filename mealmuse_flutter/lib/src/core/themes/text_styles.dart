import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:meal_muse/src/core/themes/colors.dart";

class AppTextStyles {
  // 22px Section Headers (Bold)
  static final TextStyle pageTitle = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.33, // -0.015em
    color: AppColors.charcoal,
  );

  // 18px Primary Page Titles
  static final TextStyle sectionHeader = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.27,
    color: AppColors.charcoal,
  );

  // 16px Body Text
  static final TextStyle bodyText = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.charcoal,
  );

  // 14px Metadata/Labels
  static final TextStyle labelMuted = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    color: AppColors.mutedText,
  );
}
