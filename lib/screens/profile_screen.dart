import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_user.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_snackbar.dart';
import 'alerts_screen.dart';
import 'about_app_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'map_screen.dart';
import 'profile_accessibility_screen.dart';
import 'profile_data_screen.dart';
import 'profile_help_screen.dart';
import 'profile_preferences_screen.dart';
import 'shelters_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.showBottomNavigation = true,
    this.onNavigationRequested,
    this.onBackRequested,
  });

  final bool showBottomNavigation;
  final ValueChanged<int>? onNavigationRequested;
  final VoidCallback? onBackRequested;

  void _showMessage(BuildContext context, String message) {
    AppSnackBar.show(context, message);
  }

  void _openOption(BuildContext context, String option) {
    final Widget? destination = switch (option) {
      'Meus dados' => const ProfileDataScreen(),
      'Preferências' => const ProfilePreferencesScreen(),
      'Acessibilidade' => const ProfileAccessibilityScreen(),
      'Ajuda e suporte' => const ProfileHelpScreen(),
      'Sobre o app' => const AboutAppScreen(),
      _ => null,
    };

    if (destination == null) {
      _showMessage(context, '$option estará disponível em breve.');
      return;
    }
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => destination));
  }

  void _goBack(BuildContext context) {
    if (onBackRequested != null) {
      onBackRequested!();
      return;
    }
    if (onNavigationRequested != null) {
      onNavigationRequested!(0);
      return;
    }
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
      backgroundColor: Colors.white,
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
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32,
                ),
                child: Column(
                  children: [
                    _ProfileHeader(
                      onBack: () => _goBack(context),
                      showBackButton: true,
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
    return Row(
      children: [
        if (showBackButton)
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
                'Meu perfil',
                style: AppTypography.heading.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkAmethyst,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Gerencie suas informações e preferências.',
                style: AppTypography.body.copyWith(
                  fontSize: 14,
                  color: AppColors.darkAmethyst.withValues(alpha: 0.82),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserSummary extends StatelessWidget {
  const _UserSummary({required this.user, required this.onEditPhoto});

  final MockUser user;
  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkAmethyst.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
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
          const SizedBox(width: 18),
          Container(width: 1, height: 72, color: AppColors.lavenderVeil),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.fullName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.nightBordeaux,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        color: Colors.white,
        elevation: 1,
        shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: Icon(icon, color: AppColors.hotRose, size: 23),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(fontSize: 16),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.darkAmethyst,
                  size: 24,
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
      child: FilledButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.logout_outlined, size: 24),
        label: const Text('Sair da conta'),
        style: FilledButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.hotRose,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: AppTypography.body.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
