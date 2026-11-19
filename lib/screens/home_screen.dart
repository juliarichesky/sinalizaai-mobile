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
      backgroundColor: Colors.transparent,
      bottomNavigationBar: showBottomNavigation
          ? AppBottomNavigation(
              selectedIndex: 0,
              onItemSelected: (index) => _navigate(context, index),
            )
          : null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/home_img.png', fit: BoxFit.cover),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Header(
                          firstName: mockUser.fullName.trim().isEmpty
                              ? 'usuário'
                              : mockUser.fullName.trim().split(' ').first,
                        ),
                        const SizedBox(height: 54),
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
                              onTap: () => _navigate(context, 3),
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
                        const _NotificationInfoCard(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.firstName});

  final String firstName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olá, $firstName!',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.heading.copyWith(
            color: AppColors.darkAmethyst,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Bem-vindo!',
          style: AppTypography.body.copyWith(
            color: AppColors.darkAmethyst,
            fontSize: 16,
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
        borderRadius: BorderRadius.circular(22),
        elevation: 2,
        shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: AppColors.lavenderVeil.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(icon, color: AppColors.hotRose, size: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTypography.subtitle.copyWith(
                        color: AppColors.darkAmethyst,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationInfoCard extends StatefulWidget {
  const _NotificationInfoCard();

  @override
  State<_NotificationInfoCard> createState() => _NotificationInfoCardState();
}

class _NotificationInfoCardState extends State<_NotificationInfoCard> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Notificações',
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 12, 16),
        decoration: BoxDecoration(
          color: AppColors.sunflowerGold.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Icon(
                Icons.notifications_active_outlined,
                color: AppColors.hotRose,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fique sempre informado',
                    style: AppTypography.subtitle.copyWith(
                      color: AppColors.darkAmethyst,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Ative ou desative os alertas do aplicativo.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.nightBordeaux,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.78,
              child: Switch.adaptive(
                value: _notificationsEnabled,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.hotRose,
                inactiveThumbColor: AppColors.hotRose,
                inactiveTrackColor: Colors.white,
                onChanged: (enabled) {
                  setState(() => _notificationsEnabled = enabled);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
