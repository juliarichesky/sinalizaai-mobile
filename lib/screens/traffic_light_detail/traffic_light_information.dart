part of '../traffic_light_detail_screen.dart';

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
