import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class AccessibilityResourceScaffold extends StatelessWidget {
  const AccessibilityResourceScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

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
                  AccessibilityResourceHeader(title: title, subtitle: subtitle),
                  const SizedBox(height: 24),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccessibilityResourceHeader extends StatelessWidget {
  const AccessibilityResourceHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
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
                title,
                style: AppTypography.heading.copyWith(
                  color: AppColors.darkAmethyst,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
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

class AccessibilityIntroCard extends StatelessWidget {
  const AccessibilityIntroCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.hotRose, size: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 6),
                Text(description, style: AppTypography.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccessibilityInfoCard extends StatelessWidget {
  const AccessibilityInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.hotRose, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.body.copyWith(
                    color: AppColors.darkAmethyst,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography.caption.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccessibilitySectionTitle extends StatelessWidget {
  const AccessibilitySectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.subtitle.copyWith(
        color: AppColors.darkAmethyst,
        fontSize: 20,
      ),
    );
  }
}

class AccessibilityEmptyState extends StatelessWidget {
  const AccessibilityEmptyState({
    super.key,
    required this.icon,
    required this.message,
  });

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        children: [
          Icon(icon, color: AppColors.hotRose, size: 34),
          const SizedBox(height: 8),
          Text(
            'Nenhum cadastro disponível',
            style: AppTypography.body.copyWith(
              color: AppColors.darkAmethyst,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  const _WhiteCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(22),
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    );
  }
}
