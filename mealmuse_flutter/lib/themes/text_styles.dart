import "package:flutter/material.dart";
import"package:google_fonts/google_fonts.dart";

class AppTextStyles
{
  //Body includes normal text for paragraphs and general content
  static final TextStyle bodyText = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  //Heading includes titles and section headers
  static final TextStyle headingsText = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  //Subheadings includes subtitles and smaller section headers
  static final TextStyle subHeadingsText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}