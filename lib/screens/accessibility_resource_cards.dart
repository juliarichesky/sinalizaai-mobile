part of 'accessibility_resource_widgets.dart';

class AccessibilityIntroCard extends StatelessWidget {
  const AccessibilityIntroCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.hotRose, size: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 6),
                Text(description, style: AppTypography.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccessibilityInfoCard extends StatelessWidget {
  const AccessibilityInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.hotRose, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.body.copyWith(
                    color: AppColors.darkAmethyst,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography.caption.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccessibilitySectionTitle extends StatelessWidget {
  const AccessibilitySectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.subtitle.copyWith(
        color: AppColors.darkAmethyst,
        fontSize: 20,
      ),
    );
  }
}

class AccessibilityEmptyState extends StatelessWidget {
  const AccessibilityEmptyState({
    super.key,
    required this.icon,
    required this.message,
  });

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        children: [
          Icon(icon, color: AppColors.hotRose, size: 34),
          const SizedBox(height: 8),
          Text(
            'Nenhum cadastro disponível',
            style: AppTypography.body.copyWith(
              color: AppColors.darkAmethyst,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  const _WhiteCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(22),
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    );
  }
}
