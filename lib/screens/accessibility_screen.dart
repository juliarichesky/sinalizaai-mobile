import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
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
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
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
                      style: AppTypography.subtitle.copyWith(fontSize: 17),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Encontre trajetos seguros com rampas, pisos táteis, '
                      'calçadas adequadas e semáforos sonoros.',
                      style: AppTypography.caption.copyWith(fontSize: 12),
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
                      style: AppTypography.subtitle.copyWith(fontSize: 14),
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
    return SizedBox(
      height: 42,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              tooltip: 'Voltar',
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: AppColors.darkAmethyst,
            ),
          ),
          Text(
            'Acessibilidade',
            style: AppTypography.subtitle.copyWith(fontSize: 16),
          ),
        ],
      ),
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
          borderRadius: BorderRadius.circular(14),
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
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.hotRose,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: AppTypography.body.copyWith(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: const Text('Buscar rota acessível'),
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
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(11),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(11),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.hotRose.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.hotRose, size: 17),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body.copyWith(fontSize: 12),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.darkAmethyst,
                  size: 19,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
