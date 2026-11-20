import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_alerts.dart';

part 'alert_detail/alert_detail_content.dart';
part 'alert_detail/alert_detail_sections.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key, required this.alert});

  final MockAlert alert;

  Color get _accentColor {
    switch (alert.category) {
      case AlertCategory.flood:
        return AppColors.sunflowerGold;
      case AlertCategory.traffic:
        return AppColors.hotRose;
      case AlertCategory.maintenance:
        return AppColors.darkAmethyst;
    }
  }

  String get _categoryLabel {
    switch (alert.category) {
      case AlertCategory.flood:
        return 'Enchente';
      case AlertCategory.traffic:
        return 'Trânsito';
      case AlertCategory.maintenance:
        return 'Manutenção';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/all_img.png', fit: BoxFit.cover),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(onBack: () => Navigator.of(context).pop()),
                  const SizedBox(height: 24),
                  _MainAlertCard(
                    alert: alert,
                    accentColor: _accentColor,
                    categoryLabel: _categoryLabel,
                  ),
                  if (alert.location != null) ...[
                    const SizedBox(height: 14),
                    _SectionCard(
                      title: 'Localização',
                      icon: Icons.location_on_outlined,
                      child: Text(
                        alert.location!,
                        style: AppTypography.body.copyWith(
                          color: AppColors.darkAmethyst,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  _SectionCard(
                    title: 'Sobre este alerta',
                    icon: Icons.info_outline,
                    child: Text(alert.description, style: AppTypography.body),
                  ),
                  const SizedBox(height: 14),
                  _SectionCard(
                    title: 'Orientações de segurança',
                    icon: Icons.shield_outlined,
                    child: Text(
                      'Não há orientações específicas cadastradas para este alerta demonstrativo.',
                      style: AppTypography.body,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _SectionCard(
                    title: 'Informações complementares',
                    icon: Icons.schedule_outlined,
                    child: _InfoRows(alert: alert),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dados demonstrativos. Não representam monitoramento em tempo real.',
                    textAlign: TextAlign.center,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.darkAmethyst.withValues(alpha: 0.68),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

