part of '../traffic_light_detail_screen.dart';

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    return _MetricCard(
      title: 'Status atual',
      icon: Icons.traffic,
      value: point.status,
      color: _statusColor(point.status),
    );
  }
}

class _TimeCard extends StatelessWidget {
  const _TimeCard({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    return _MetricCard(
      title: 'Tempo para troca',
      icon: Icons.timer_outlined,
      value: point.changeTime ?? 'Não informado',
      color: AppColors.darkAmethyst,
    );
  }
}

class _FlowCard extends StatelessWidget {
  const _FlowCard({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    final flowLabel = _flowLabel(point.flow);
    return _MetricCard(
      title: 'Fluxo',
      icon: Icons.directions_car_outlined,
      value: flowLabel,
      color: _flowColor(flowLabel),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.color,
  });

  final String title;
  final IconData icon;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 38,
            width: 38,
            child: Icon(icon, color: AppColors.hotRose, size: 21),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: AppTypography.caption.copyWith(
                color: AppColors.darkAmethyst,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 150),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

