import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_user.dart';
import '../widgets/app_snackbar.dart';
import 'profile_subpage_widgets.dart';

class ProfileDataScreen extends StatefulWidget {
  const ProfileDataScreen({super.key});

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final user = activeUser ?? mockUser;
    _nameController = TextEditingController(text: user.fullName);
    _emailController = TextEditingController(text: user.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _save() {
    if (_nameController.text.trim().isEmpty ||
        !_emailController.text.contains('@')) {
      AppSnackBar.show(
        context,
        'Informe um nome e um e-mail válidos.',
        type: AppSnackBarType.error,
      );
      return;
    }
    AppSnackBar.show(
      context,
      'Alterações salvas apenas nesta demonstração.',
      type: AppSnackBarType.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfileSubpageScaffold(
      title: 'Meus dados',
      subtitle: 'Visualize e atualize suas informações pessoais.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileWhiteCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: AppColors.sunflowerGold,
                  child: Text(
                    (activeUser ?? mockUser).initials,
                    style: AppTypography.heading.copyWith(
                      color: AppColors.hotRose,
                      fontSize: 23,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (activeUser ?? mockUser).fullName,
                        style: AppTypography.subtitle,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        (activeUser ?? mockUser).email,
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _DataField(
            label: 'Nome completo',
            controller: _nameController,
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 12),
          _DataField(
            label: 'E-mail',
            controller: _emailController,
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save_outlined, size: 21),
            label: const Text('Salvar alterações'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.hotRose,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataField extends StatelessWidget {
  const _DataField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.darkAmethyst),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.lavenderVeil),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.lavenderVeil),
        ),
      ),
    );
  }
}
