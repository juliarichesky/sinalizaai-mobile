import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static final TextStyle heading = GoogleFonts.dmSans(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.darkAmethyst,
  );

  static final TextStyle subtitle = GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkAmethyst,
  );

  static final TextStyle body = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.darkAmethyst,
  );

  static final TextStyle caption = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.nightBordeaux,
  );

  static TextTheme get textTheme => TextTheme(
    headlineSmall: heading,
    titleMedium: subtitle,
    bodyMedium: body,
    bodySmall: caption,
  );
}
