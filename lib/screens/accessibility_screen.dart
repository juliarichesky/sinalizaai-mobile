import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../widgets/app_snackbar.dart';
import 'home_screen.dart';

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
                      onTap: () => _showMessage(
                        context,
                        'Rotas com rampas estarão disponíveis em breve.',
                      ),
                    ),
                    const SizedBox(height: 7),
                    _AccessibilityResource(
                      icon: Icons.volume_up_outlined,
                      label: 'Semáforos sonoros',
                      onTap: () => _showMessage(
                        context,
                        'Semáforos sonoros estarão disponíveis em breve.',
                      ),
                    ),
                    const SizedBox(height: 7),
                    _AccessibilityResource(
                      icon: Icons.wheelchair_pickup,
                      label: 'Calçadas acessíveis',
                      onTap: () => _showMessage(
                        context,
                        'Calçadas acessíveis estarão disponíveis em breve.',
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

class _AccessibilityHeader extends StatelessWidget {
  const _AccessibilityHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                'Acessibilidade',
                style: AppTypography.heading.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkAmethyst,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Mobilidade mais inclusiva para todos.',
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

class _AccessibilityIllustration extends StatelessWidget {
  const _AccessibilityIllustration();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Ilustração demonstrativa de mobilidade acessível',
      image: true,
      child: AspectRatio(
        aspectRatio: 2.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lavenderVeil,
                  AppColors.hotRose.withValues(alpha: 0.18),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -14,
                  bottom: -28,
                  child: Container(
                    height: 92,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 16,
                  child: Icon(
                    Icons.accessible_forward,
                    color: AppColors.darkAmethyst.withValues(alpha: 0.85),
                    size: 58,
                  ),
                ),
                Positioned(
                  left: 22,
                  bottom: 18,
                  child: Row(
                    children: [
                      Icon(
                        Icons.sign_language,
                        color: AppColors.hotRose.withValues(alpha: 0.8),
                        size: 32,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 8,
                        width: 82,
                        decoration: BoxDecoration(
                          color: AppColors.hotRose.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
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

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.search, size: 22),
        label: const Text('Buscar rota acessível'),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.hotRose,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
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

class _AccessibilityResource extends StatelessWidget {
  const _AccessibilityResource({
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
                    style: AppTypography.body.copyWith(fontSize: 16),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.darkAmethyst,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
