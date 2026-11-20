part of '../alerts_screen.dart';

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.alert,
    required this.color,
    required this.onTap,
  });

  final MockAlert alert;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${alert.title}. ${alert.description}. ${alert.time}',
      child: Material(
        color: Colors.white,
        elevation: 2,
        shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 52,
                  width: 52,
                  child: Icon(alert.icon, color: color, size: 27),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.title,
                        style: AppTypography.subtitle.copyWith(
                          color: AppColors.darkAmethyst,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        alert.description,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.nightBordeaux,
                          fontSize: 14,
                        ),
                      ),
                      if (alert.location != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          alert.location!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.nightBordeaux,
                            fontSize: 14,
                          ),
                        ),
                      ],
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          alert.time,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.nightBordeaux,
                            fontSize: 13,
                          ),
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
