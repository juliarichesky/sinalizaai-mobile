import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'profile_subpage_widgets.dart';

class ProfilePreferencesScreen extends StatelessWidget {
  const ProfilePreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSubpageScaffold(
      title: 'Preferências',
      subtitle: 'Personalize sua experiência no aplicativo.',
      child: Column(
        children: const [
          _UnavailablePreference(icon: Icons.notifications_none, title: 'Notificações', description: 'Controle de notificações estará disponível em breve.'),
          SizedBox(height: 12),
          _UnavailablePreference(icon: Icons.palette_outlined, title: 'Aparência', description: 'Personalização de tema estará disponível em breve.'),
          SizedBox(height: 12),
          _UnavailablePreference(icon: Icons.tune, title: 'Configurações gerais', description: 'Mais configurações estarão disponíveis em breve.'),
        ],
      ),
    );
  }
}

class _UnavailablePreference extends StatelessWidget {
  const _UnavailablePreference({required this.icon, required this.title, required this.description});

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ProfileWhiteCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.hotRose, size: 28),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTypography.subtitle),
            const SizedBox(height: 3),
            Text(description, style: AppTypography.caption),
          ])),
          Text('Em breve', style: AppTypography.caption.copyWith(color: AppColors.hotRose, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
