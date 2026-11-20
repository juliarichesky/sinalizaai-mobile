part of '../traffic_light_detail_screen.dart';

class _TrafficLightHeader extends StatelessWidget {
  const _TrafficLightHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
      child: Row(
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
                  'Detalhes do semáforo',
                  style: AppTypography.heading.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Acompanhe as condições do cruzamento.',
                  style: AppTypography.body.copyWith(
                    fontSize: 14,
                    color: AppColors.darkAmethyst.withValues(alpha: 0.82),
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

class _TrafficLightImage extends StatelessWidget {
  const _TrafficLightImage({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: point.imageAsset == null
            ? DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkAmethyst.withValues(alpha: 0.12),
                      AppColors.lavenderVeil,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.traffic,
                    color: AppColors.hotRose,
                    size: 58,
                  ),
                ),
              )
            : Image.asset(point.imageAsset!, fit: BoxFit.cover),
      ),
    );
  }
}

class _TrafficLightIdentity extends StatelessWidget {
  const _TrafficLightIdentity({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.darkAmethyst,
          size: 19,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            point.address ?? point.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.subtitle.copyWith(fontSize: 18),
          ),
        ),
      ],
    );
  }
}

