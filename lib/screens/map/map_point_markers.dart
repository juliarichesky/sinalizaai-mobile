part of '../map_screen.dart';

class _DetailsButton extends StatelessWidget {
  const _DetailsButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.darkAmethyst,
        side: const BorderSide(color: AppColors.darkAmethyst),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        minimumSize: const Size(48, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      icon: const Icon(Icons.chevron_right, size: 20),
      label: const Text('Detalhes'),
    );
  }
}

class _MapMarker extends StatelessWidget {
  const _MapMarker({
    required this.point,
    required this.isSelected,
    required this.onTap,
  });

  final MapPoint point;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _pointColor(point);
    final icon = point.kind == MapPointKind.flood ? Icons.water : Icons.traffic;

    return Semantics(
      button: true,
      selected: isSelected,
      label: point.name,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          width: 56,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Icon(Icons.location_on, color: color, size: isSelected ? 54 : 50),
              Positioned(
                top: 9,
                child: Icon(icon, color: Colors.white, size: 19),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PointInfoCard extends StatelessWidget {
  const _PointInfoCard({required this.point, required this.onDetails});

  final MapPoint point;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    final color = _pointColor(point);
    final icon = point.kind == MapPointKind.flood ? Icons.water : Icons.traffic;

    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 10, 14),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 54,
              decoration: BoxDecoration(
                color: AppColors.darkAmethyst.withValues(alpha: 0.28),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 27),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 52,
                  color: AppColors.darkAmethyst.withValues(alpha: 0.14),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        point.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.subtitle.copyWith(
                          fontSize: 16,
                          color: AppColors.darkAmethyst,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text.rich(
                        TextSpan(
                          text: 'Status: ',
                          style: AppTypography.caption,
                          children: [
                            TextSpan(
                              text: point.status,
                              style: AppTypography.caption.copyWith(
                                color: color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Fluxo: ',
                          style: AppTypography.caption,
                          children: [
                            TextSpan(
                              text: point.flow,
                              style: AppTypography.caption.copyWith(
                                color: color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _DetailsButton(onPressed: onDetails),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color _pointColor(MapPoint point) {
  if (point.kind == MapPointKind.flood) {
    return Colors.blue;
  }
  return point.status == 'Atenção' ? Colors.red : Colors.green;
}

