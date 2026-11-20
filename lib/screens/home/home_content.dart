part of '../home_screen.dart';

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
                SizedBox(
                  height: 58,
                  width: 58,
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

class _NotificationInfoCard extends StatelessWidget {
  const _NotificationInfoCard();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppPreferences.instance.notificationsEnabled,
      builder: (context, notificationsEnabled, _) => Semantics(
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
              const SizedBox(
                height: 54,
                width: 54,
                child: Icon(
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
                  value: notificationsEnabled,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.hotRose,
                  inactiveThumbColor: AppColors.hotRose,
                  inactiveTrackColor: Colors.white,
                  trackOutlineColor: MaterialStateProperty.resolveWith(
                    (states) =>
                        states.contains(MaterialState.hovered) ||
                            states.contains(MaterialState.selected)
                        ? AppColors.hotRose
                        : Colors.white,
                  ),
                  trackOutlineWidth: MaterialStatePropertyAll(0),
                  onChanged: (enabled) {
                    AppPreferences.instance.setNotificationsEnabled(enabled);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
