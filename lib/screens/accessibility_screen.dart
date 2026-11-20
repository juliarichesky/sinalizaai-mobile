import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../widgets/app_snackbar.dart';
import 'home_screen.dart';
import 'accessible_sidewalks_screen.dart';
import 'audible_traffic_lights_screen.dart';
import 'ramp_routes_screen.dart';

part 'accessibility/accessibility_content.dart';
part 'accessibility/accessibility_actions.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  void _goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  void _showMessage(BuildContext context, String message) {
    AppSnackBar.show(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _AccessibilityHeader(onBack: () => _goBack(context)),
                    const SizedBox(height: 10),
                    const _AccessibilityIllustration(),
                    const SizedBox(height: 16),
                    Text(
                      'Rotas mais inclusivas',
                      style: AppTypography.subtitle.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Encontre trajetos seguros com rampas, pisos táteis, '
                      'calçadas adequadas e semáforos sonoros.',
                      style: AppTypography.caption.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 18),
                    _PrimaryButton(
                      onTap: () => _showMessage(
                        context,
                        'A busca de rotas acessíveis estará disponível em breve.',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Recursos disponíveis',
                      style: AppTypography.subtitle.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    _AccessibilityResource(
                      icon: Icons.accessibility_new,
                      label: 'Rotas com rampas',
                      onTap: () => Navigator.of(context).push(
                        PageRouteBuilder<void>(
                          pageBuilder: (_, __, ___) => const RampRoutesScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    _AccessibilityResource(
                      icon: Icons.volume_up_outlined,
                      label: 'Semáforos sonoros',
                      onTap: () => Navigator.of(context).push(
                        PageRouteBuilder<void>(
                          pageBuilder: (_, __, ___) =>
                              const AudibleTrafficLightsScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    _AccessibilityResource(
                      icon: Icons.wheelchair_pickup,
                      label: 'Calçadas acessíveis',
                      onTap: () => Navigator.of(context).push(
                        PageRouteBuilder<void>(
                          pageBuilder: (_, __, ___) =>
                              const AccessibleSidewalksScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      ),
                    ),
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

