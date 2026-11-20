import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
import '../services/local_auth_service.dart';

part 'profile/profile_content.dart';
part 'profile/profile_layout.dart';
part 'profile/profile_summary.dart';

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

  Future<void> _changePhoto(BuildContext context) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null || !context.mounted) {
      return;
    }

    try {
      await LocalAuthService.instance.updateAvatarPath(image.path);
      if (!context.mounted) return;
      AppSnackBar.show(
        context,
        'Foto de perfil atualizada.',
        type: AppSnackBarType.success,
      );
    } on LocalAuthException catch (error) {
      if (!context.mounted) return;
      AppSnackBar.show(context, error.message, type: AppSnackBarType.error);
    }
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

    await LocalAuthService.instance.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) => _buildContent(context);
}
