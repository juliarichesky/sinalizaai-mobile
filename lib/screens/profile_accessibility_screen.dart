import 'package:flutter/material.dart';

import '../widgets/app_snackbar.dart';
import 'accessibility_screen.dart';
import 'profile_subpage_widgets.dart';

class ProfileAccessibilityScreen extends StatelessWidget {
  const ProfileAccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSubpageScaffold(
      title: 'Acessibilidade',
      subtitle: 'Uma experiência mais confortável para você.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileActionCard(
            icon: Icons.accessibility_new,
            title: 'Ajustes de visualização',
            description:
                'A escala de texto segue as configurações do seu dispositivo.',
            onTap: () => _showUnavailable(context),
          ),
          const SizedBox(height: 12),
          ProfileActionCard(
            icon: Icons.touch_app_outlined,
            title: 'Recursos de navegação acessível',
            description: 'Recursos adicionais estarão disponíveis em breve.',
            onTap: () => _showUnavailable(context),
          ),
          const SizedBox(height: 12),
          ProfileActionCard(
            icon: Icons.route_outlined,
            title: 'Explorar rotas acessíveis',
            description:
                'Conheça os recursos de mobilidade inclusiva do Sinaliza.Ai.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const AccessibilityScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUnavailable(BuildContext context) {
    AppSnackBar.show(
      context,
      'Este recurso estará disponível em breve.',
      type: AppSnackBarType.info,
    );
  }
}
