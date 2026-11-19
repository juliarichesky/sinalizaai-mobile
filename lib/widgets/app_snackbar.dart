import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

enum AppSnackBarType { success, error, warning, info }

abstract final class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: _Content(message: message, type: type),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          duration: duration,
          elevation: 4,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.message, required this.type});

  final String message;
  final AppSnackBarType type;

  IconData get _icon {
    switch (type) {
      case AppSnackBarType.success:
        return Icons.check_circle_outline;
      case AppSnackBarType.error:
        return Icons.error_outline;
      case AppSnackBarType.warning:
        return Icons.warning_amber_rounded;
      case AppSnackBarType.info:
        return Icons.info_outline;
    }
  }

  Color get _iconColor {
    switch (type) {
      case AppSnackBarType.success:
        return Colors.green;
      case AppSnackBarType.error:
        return AppColors.hotRose;
      case AppSnackBarType.warning:
        return AppColors.sunflowerGold;
      case AppSnackBarType.info:
        return AppColors.darkAmethyst;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_icon, color: _iconColor, size: 21),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: AppTypography.body.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
