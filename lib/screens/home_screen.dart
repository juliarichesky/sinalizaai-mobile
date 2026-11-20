import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/app_preferences.dart';
import '../data/mock_user.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_snackbar.dart';
import 'alerts_screen.dart';
import 'accessibility_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'shelters_screen.dart';

part 'home/home_content.dart';

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
                          firstName:
                              (activeUser ?? mockUser).fullName.trim().isEmpty
                              ? 'usuário'
                              : (activeUser ?? mockUser).fullName
                                    .trim()
                                    .split(' ')
                                    .first,
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
                                PageRouteBuilder<void>(
                                  pageBuilder: (_, __, ___) =>
                                      const AccessibilityScreen(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
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

