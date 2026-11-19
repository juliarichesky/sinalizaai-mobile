import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_alerts.dart';

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

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onBack,
          tooltip: 'Voltar',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          icon: const Icon(Icons.arrow_back_ios_new, size: 22),
          color: AppColors.darkAmethyst,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalhes do alerta',
                style: AppTypography.heading.copyWith(
                  color: AppColors.darkAmethyst,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Confira as informações e orientações sobre este aviso.',
                style: AppTypography.body.copyWith(
                  color: AppColors.darkAmethyst.withValues(alpha: 0.82),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MainAlertCard extends StatelessWidget {
  const _MainAlertCard({
    required this.alert,
    required this.accentColor,
    required this.categoryLabel,
  });

  final MockAlert alert;
  final Color accentColor;
  final String categoryLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(alert.icon, color: AppColors.hotRose, size: 34),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert.title,
                    style: AppTypography.subtitle.copyWith(
                      color: AppColors.darkAmethyst,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      categoryLabel,
                      style: AppTypography.caption.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nível de risco não informado',
                    style: AppTypography.body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.hotRose, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.subtitle.copyWith(
                      color: AppColors.darkAmethyst,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoRows extends StatelessWidget {
  const _InfoRows({required this.alert});

  final MockAlert alert;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow(label: 'Atualização', value: alert.time),
        _InfoRow(label: 'Status', value: 'Demonstrativo'),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: AppTypography.caption)),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTypography.caption.copyWith(
                color: AppColors.darkAmethyst,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
