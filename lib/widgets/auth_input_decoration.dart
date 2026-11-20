import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

InputDecoration authInputDecoration({
  required String label,
  required IconData icon,
  Widget? suffixIcon,
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.lavenderVeil),
  );

  return InputDecoration(
    labelText: label,
    labelStyle: AppTypography.caption,
    prefixIcon: Icon(icon, size: 18, color: AppColors.darkAmethyst),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.45),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: border,
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: const BorderSide(color: AppColors.hotRose, width: 2),
    ),
    errorBorder: border.copyWith(
      borderSide: const BorderSide(color: AppColors.nightBordeaux),
    ),
    focusedErrorBorder: border.copyWith(
      borderSide: const BorderSide(color: AppColors.nightBordeaux, width: 2),
    ),
    errorStyle: AppTypography.caption.copyWith(
      color: AppColors.nightBordeaux,
    ),
  );
}
