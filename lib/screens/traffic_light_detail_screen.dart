import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_map_points.dart';

class TrafficLightDetailScreen extends StatelessWidget {
  const TrafficLightDetailScreen({super.key, required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/all_img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _TrafficLightHeader(onBack: () => Navigator.of(context).pop()),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _TrafficLightImage(point: point),
                      const SizedBox(height: 14),
                      _TrafficLightIdentity(point: point),
                      const SizedBox(height: 16),
                      _StatusCard(point: point),
                      const SizedBox(height: 8),
                      _TimeCard(point: point),
                      const SizedBox(height: 8),
                      _FlowCard(point: point),
                      if (point.address != null ||
                          point.intersection != null ||
                          point.operationMode != null ||
                          point.lastUpdated != null) ...[
                        const SizedBox(height: 18),
                        _CrossingInformation(point: point),
                      ],
                      const SizedBox(height: 12),
                      Text(
                        'Dados demonstrativos. As informações não representam '
                        'condições verificadas em tempo real.',
                        textAlign: TextAlign.center,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.nightBordeaux.withValues(
                            alpha: 0.75,
                          ),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class _CrossingInformation extends StatelessWidget {
  const _CrossingInformation({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      if (point.intersection != null)
        _InformationRow(label: 'Identificação', value: point.intersection!),
      if (point.address != null)
        _InformationRow(label: 'Endereço', value: point.address!),
      if (point.operationMode != null)
        _InformationRow(label: 'Modo de operação', value: point.operationMode!),
      if (point.lastUpdated != null)
        _InformationRow(label: 'Última atualização', value: point.lastUpdated!),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informações do cruzamento',
            style: AppTypography.subtitle.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          ...rows,
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  const _InformationRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$label\n',
                style: AppTypography.caption.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: AppTypography.caption.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _statusColor(String status) {
  switch (status) {
    case 'Liberado':
      return const Color(0xFF3D8B5A);
    case 'Atenção':
      return AppColors.sunflowerGold;
    case 'Parado':
      return AppColors.hotRose;
    default:
      return AppColors.darkAmethyst.withValues(alpha: 0.65);
  }
}

String _flowLabel(String flow) {
  if (flow == 'Fluxo normal') {
    return 'Normal';
  }
  if (flow == 'Fluxo moderado') {
    return 'Moderado';
  }
  if (flow == 'Fluxo intenso') {
    return 'Intenso';
  }
  return 'Não informado';
}

Color _flowColor(String flow) {
  switch (flow) {
    case 'Normal':
      return const Color(0xFF3D8B5A);
    case 'Moderado':
      return AppColors.sunflowerGold;
    case 'Intenso':
      return AppColors.hotRose;
    default:
      return AppColors.darkAmethyst.withValues(alpha: 0.65);
  }
}
