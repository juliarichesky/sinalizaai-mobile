import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_map_points.dart';

part 'traffic_light_detail/traffic_light_detail_content.dart';
part 'traffic_light_detail/traffic_light_information.dart';
part 'traffic_light_detail/traffic_light_metrics.dart';

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

