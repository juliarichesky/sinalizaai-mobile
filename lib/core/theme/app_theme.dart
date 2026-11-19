import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.hotRose,
      onPrimary: Colors.white,
      secondary: AppColors.sunflowerGold,
      onSecondary: AppColors.darkAmethyst,
      surface: Colors.white,
      onSurface: AppColors.darkAmethyst,
      error: AppColors.nightBordeaux,
      onError: Colors.white,
    ),
    fontFamily: AppTypography.body.fontFamily!,
    textTheme: AppTypography.textTheme,
  );
}
