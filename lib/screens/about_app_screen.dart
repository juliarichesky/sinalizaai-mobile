import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'profile_subpage_widgets.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSubpageScaffold(
      title: 'Sobre o app',
      subtitle: 'Conheça o Sinaliza.Ai.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileWhiteCard(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo_colorida.png',
                  width: 190,
                  height: 72,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Text(
                  'Mobilidade inteligente, cidades mais seguras.',
                  textAlign: TextAlign.center,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ProfileWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sobre o projeto',
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'O Sinaliza.Ai é um aplicativo voltado à mobilidade urbana, acessibilidade e informações relacionadas a semáforos, alertas e abrigos.',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ProfileWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Funcionalidades',
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 12),
                _Feature(label: 'Mapa e semáforos', icon: Icons.map_outlined),
                _Feature(label: 'Abrigos', icon: Icons.home_work_outlined),
                _Feature(label: 'Alertas', icon: Icons.notifications_none),
                _Feature(
                  label: 'Acessibilidade',
                  icon: Icons.accessibility_new,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ProfileWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações do aplicativo',
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Versão 1.0.0', style: AppTypography.body),
                const SizedBox(height: 14),
                Text(
                  'Projeto acadêmico',
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Desenvolvido como projeto acadêmico da Global Solution FIAP 2026/2.',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.hotRose, size: 22),
          const SizedBox(width: 10),
          Text(label, style: AppTypography.body),
        ],
      ),
    );
  }
}
