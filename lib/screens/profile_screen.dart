import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_user.dart';
import '../widgets/app_bottom_navigation.dart';
import 'alerts_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'map_screen.dart';
import 'shelters_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.showBottomNavigation = true,
    this.onNavigationRequested,
  });

  final bool showBottomNavigation;
  final ValueChanged<int>? onNavigationRequested;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _openOption(BuildContext context, String option) {
    _showMessage(context, '$option estará disponível em breve.');
  }

  void _goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    if (onNavigationRequested != null) {
      onNavigationRequested!(index);
      return;
    }
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
        );
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const MapScreen()),
        );
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const SheltersScreen()),
        );
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const AlertsScreen()),
        );
      case 4:
        break;
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Sair da conta', style: AppTypography.subtitle),
        content: Text(
          'Deseja realmente sair da sua conta?',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (shouldSignOut != true || !context.mounted) {
      return;
    }

    // Ainda não há sessão persistente neste protótipo para limpar.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      bottomNavigationBar: showBottomNavigation
          ? AppBottomNavigation(
              selectedIndex: 4,
              onItemSelected: (index) => _handleNavigation(context, index),
            )
          : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32,
                ),
                child: Column(
                  children: [
                    _ProfileHeader(
                      onBack: () => _goBack(context),
                      showBackButton: showBottomNavigation,
                    ),
                    const SizedBox(height: 20),
                    _UserSummary(
                      user: mockUser,
                      onEditPhoto: () => _showMessage(
                        context,
                        'A troca de foto estará disponível em breve.',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...[
                      (Icons.person_outline, 'Meus dados'),
                      (Icons.settings_outlined, 'Preferências'),
                      (Icons.accessibility_new, 'Acessibilidade'),
                      (Icons.help_outline, 'Ajuda e suporte'),
                      (Icons.info_outline, 'Sobre o app'),
                    ].map(
                      (option) => Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: _ProfileOption(
                          icon: option.$1,
                          label: option.$2,
                          onTap: () => _openOption(context, option.$2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SignOutButton(onTap: () => _confirmSignOut(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onBack, required this.showBackButton});

  final VoidCallback onBack;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: onBack,
                tooltip: 'Voltar',
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                color: AppColors.darkAmethyst,
              ),
            ),
          Text(
            'Meu perfil',
            style: AppTypography.subtitle.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _UserSummary extends StatelessWidget {
  const _UserSummary({required this.user, required this.onEditPhoto});

  final MockUser user;
  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.sunflowerGold,
              child: CircleAvatar(
                radius: 31,
                backgroundColor: AppColors.hotRose.withValues(alpha: 0.12),
                child: Text(
                  user.initials,
                  style: AppTypography.heading.copyWith(
                    color: AppColors.hotRose,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -1,
              child: Material(
                color: AppColors.hotRose,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onEditPhoto,
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.edit, color: Colors.white, size: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          user.fullName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.subtitle.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 1),
        Text(
          user.email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              children: [
                Icon(icon, color: AppColors.darkAmethyst, size: 17),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(fontSize: 12),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.darkAmethyst,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.hotRose,
          side: const BorderSide(color: AppColors.hotRose),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          'Sair da conta',
          style: AppTypography.body.copyWith(
            color: AppColors.hotRose,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
