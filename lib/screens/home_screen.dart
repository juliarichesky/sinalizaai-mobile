import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../widgets/app_bottom_navigation.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String _demoFirstName = 'Julia';

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleNavigation(BuildContext context, int index) {
    if (index == 0) {
      return;
    }
    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const MapScreen()),
      );
      return;
    }

    final messages = {
      2: 'Ações rápidas estarão disponíveis em breve.',
      3: 'Alertas estarão disponíveis em breve.',
      4: 'O perfil estará disponível em breve.',
    };
    _showMessage(context, messages[index]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkAmethyst,
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: 0,
        onItemSelected: (index) => _handleNavigation(context, index),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkAmethyst,
              AppColors.nightBordeaux,
              AppColors.hotRose.withValues(alpha: 0.34),
            ],
            stops: const [0.0, 0.62, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Header(
                        firstName: _demoFirstName,
                        onNotifications: () => _showMessage(
                          context,
                          'As notificações estarão disponíveis em breve.',
                        ),
                      ),
                      const SizedBox(height: 26),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.22,
                        children: [
                          _FeatureCard(
                            icon: Icons.traffic,
                            title: 'Trânsito',
                            description: 'Semáforos e fluxo',
                            onTap: () => _showMessage(
                              context,
                              'Trânsito estará disponível em breve.',
                            ),
                          ),
                          _FeatureCard(
                            icon: Icons.accessibility_new,
                            title: 'Acessibilidade',
                            description: 'Rotas inclusivas',
                            onTap: () => _showMessage(
                              context,
                              'Acessibilidade estará disponível em breve.',
                            ),
                          ),
                          _FeatureCard(
                            icon: Icons.notifications_none,
                            title: 'Alertas',
                            description: 'Enchentes e riscos',
                            onTap: () => _showMessage(
                              context,
                              'Alertas estarão disponíveis em breve.',
                            ),
                          ),
                          _FeatureCard(
                            icon: Icons.location_on_outlined,
                            title: 'Mapa',
                            description: 'Visualizar região',
                            onTap: () => _showMessage(
                              context,
                              'O mapa estará disponível em breve.',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Alertas da sua região',
                        style: AppTypography.subtitle.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _RegionalAlert(
                        onTap: () => _showMessage(
                          context,
                          'Os detalhes do alerta estarão disponíveis em breve.',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.firstName, required this.onNotifications});

  final String firstName;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Olá, ',
                  style: AppTypography.heading.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  children: [
                    TextSpan(
                      text: '$firstName! 👋',
                      style: AppTypography.heading.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Bem-vinda ao Sinaliza.Ai',
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onNotifications,
          tooltip: 'Notificações',
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $description',
      child: Material(
        color: AppColors.lavenderVeil,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: AppColors.hotRose.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.hotRose, size: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.nightBordeaux,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegionalAlert extends StatelessWidget {
  const _RegionalAlert({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Atenção: Risco de enchente. Nível moderado no Rio Tietê.',
      child: Material(
        color: AppColors.sunflowerGold,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.water,
                    color: AppColors.darkAmethyst,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Atenção: Risco de enchente',
                        style: AppTypography.subtitle.copyWith(
                          color: AppColors.darkAmethyst,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Nível moderado no Rio Tietê.',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.nightBordeaux,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.darkAmethyst),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
