import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_user.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_snackbar.dart';
import 'alerts_screen.dart';
import 'accessibility_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'shelters_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.showBottomNavigation = true,
    this.onNavigationRequested,
  });

  final bool showBottomNavigation;
  final ValueChanged<int>? onNavigationRequested;

  void _showMessage(BuildContext context, String message) {
    AppSnackBar.show(context, message);
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
    if (index == 2) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => const SheltersScreen()));
      return;
    }
    if (index == 3) {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => const AlertsScreen()));
      return;
    }
    if (index == 4) {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => const ProfileScreen()));
      return;
    }

    _showMessage(context, 'Esta funcionalidade estará disponível em breve.');
  }

  void _navigate(BuildContext context, int index) {
    if (onNavigationRequested != null) {
      onNavigationRequested!(index);
      return;
    }
    _handleNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: showBottomNavigation
          ? AppBottomNavigation(
              selectedIndex: 0,
              onItemSelected: (index) => _navigate(context, index),
            )
          : null,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white,
              AppColors.lavenderVeil.withValues(alpha: 0.34),
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
                        firstName: mockUser.fullName.split(' ').first,
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
                            icon: Icons.location_on_outlined,
                            title: 'Mapa',
                            description: 'Visualizar região',
                            onTap: () => _navigate(context, 1),
                          ),
                          _FeatureCard(
                            icon: Icons.accessibility_new,
                            title: 'Acessibilidade',
                            description: 'Rotas inclusivas',
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const AccessibilityScreen(),
                              ),
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
                            icon: Icons.home_work_outlined,
                            title: 'Abrigos',
                            description: 'Locais seguros',
                            onTap: () => _navigate(context, 2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Alertas da sua região',
                        style: AppTypography.subtitle.copyWith(
                          color: AppColors.darkAmethyst,
                          fontSize: 20,
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
                    color: AppColors.darkAmethyst,
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(
                      text: '$firstName! 👋',
                      style: AppTypography.heading.copyWith(
                        color: AppColors.darkAmethyst,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Bem-vinda ao Sinaliza.Ai',
                style: AppTypography.caption.copyWith(
                  color: AppColors.darkAmethyst.withValues(alpha: 0.78),
                  fontSize: 14,
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
            color: AppColors.darkAmethyst,
            size: 24,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        elevation: 1,
        shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
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
                  child: Icon(icon, color: AppColors.hotRose, size: 32),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                    fontSize: 16,
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
                    fontSize: 14,
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
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Nível moderado no Rio Tietê.',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.nightBordeaux,
                          fontSize: 14,
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
