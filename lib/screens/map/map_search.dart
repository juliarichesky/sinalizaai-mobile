import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../data/mock_map_points.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onLocationTap,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onLocationTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(22),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: AppTypography.body.copyWith(fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Buscar endereço',
          hintStyle: AppTypography.caption.copyWith(
            color: AppColors.nightBordeaux.withValues(alpha: 0.58),
            fontSize: 16,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.nightBordeaux,
            size: 25,
          ),
          suffixIcon: IconButton(
            onPressed: onLocationTap,
            tooltip: 'Usar localização',
            icon: const Icon(
              Icons.my_location_outlined,
              color: AppColors.darkAmethyst,
              size: 24,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

class MapSearchResults extends StatelessWidget {
  const MapSearchResults({
    super.key,
    required this.points,
    required this.indexes,
    required this.onSelected,
  });

  final List<MapPoint> points;
  final List<int> indexes;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      constraints: const BoxConstraints(maxHeight: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkAmethyst.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: indexes.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  'Nenhum ponto encontrado.',
                  style: AppTypography.caption,
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: indexes.length,
              itemBuilder: (context, position) {
                final point = points[indexes[position]];
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      point.kind == MapPointKind.flood
                          ? Icons.water
                          : Icons.traffic,
                      color: _pointColor(point),
                      size: 20,
                    ),
                    title: Text(point.name, style: AppTypography.body),
                    onTap: () => onSelected(indexes[position]),
                  ),
                );
              },
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
