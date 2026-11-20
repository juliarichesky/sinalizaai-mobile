part of '../accessibility_screen.dart';

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

