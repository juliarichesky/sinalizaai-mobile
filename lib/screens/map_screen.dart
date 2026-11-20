import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_map_points.dart';
import '../data/mock_shelters.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_snackbar.dart';
import 'alerts_screen.dart';
import 'home_screen.dart';
import 'shelter_detail_screen.dart';
import 'shelters_screen.dart';
import 'traffic_light_detail_screen.dart';

enum _MapMode { trafficLights, shelters }

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.showBottomNavigation = true,
    this.onNavigationRequested,
    this.onBackRequested,
  });

  final bool showBottomNavigation;
  final ValueChanged<int>? onNavigationRequested;
  final VoidCallback? onBackRequested;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  _MapMode _selectedMode = _MapMode.trafficLights;
  int _selectedTrafficIndex = 0;
  int? _selectedShelterIndex;
  String _searchQuery = '';

  List<MapPoint> get _trafficPoints => mockMapPoints
      .where((point) => point.kind == MapPointKind.trafficLight)
      .toList();

  List<Shelter> get _mappedShelters =>
      mockShelters.where((shelter) => shelter.mapPosition != null).toList();

  MapPoint get _selectedPoint => _trafficPoints[_selectedTrafficIndex];

  List<int> get _matchingPointIndexes {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return const [];
    }

    return [
      for (var index = 0; index < _trafficPoints.length; index++)
        if (_trafficPoints[index].name.toLowerCase().contains(query)) index,
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _selectTrafficPoint(int index) {
    setState(() {
      _selectedTrafficIndex = index;
      _searchQuery = '';
      _searchController.clear();
    });
    _searchFocusNode.unfocus();
  }

  void _openTrafficDetails(int index) {
    _selectTrafficPoint(index);
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) =>
            TrafficLightDetailScreen(point: _trafficPoints[index]),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  void _selectMode(_MapMode mode) {
    setState(() {
      _selectedMode = mode;
      _selectedShelterIndex = null;
      _searchQuery = '';
      _searchController.clear();
    });
    _searchFocusNode.unfocus();
    if (mode == _MapMode.shelters && _mappedShelters.isEmpty) {
      _showMessage('Os abrigos ainda não possuem localização no mapa.');
    }
  }

  void _selectShelter(int index) {
    setState(() => _selectedShelterIndex = index);
  }

  void _showMessage(String message) {
    AppSnackBar.show(context, message);
  }

  void _goBack() {
    if (widget.onBackRequested != null) {
      widget.onBackRequested!();
      return;
    }
    if (widget.onNavigationRequested != null) {
      widget.onNavigationRequested!(0);
      return;
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  void _handleNavigation(int index) {
    if (index == 1) {
      return;
    }
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
      );
      return;
    }
    if (index == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const SheltersScreen()),
      );
      return;
    }
    if (index == 3) {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => const AlertsScreen()));
      return;
    }

    _showMessage('Esta funcionalidade estará disponível em breve.');
  }

  void _navigate(int index) {
    if (widget.onNavigationRequested != null) {
      widget.onNavigationRequested!(index);
      return;
    }
    _handleNavigation(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: widget.showBottomNavigation
          ? AppBottomNavigation(selectedIndex: 1, onItemSelected: _navigate)
          : null,
      body: SafeArea(
        child: Column(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _goBack,
                      tooltip: 'Voltar',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 48,
                        minHeight: 48,
                      ),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.darkAmethyst,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mapa',
                            style: AppTypography.heading.copyWith(
                              color: AppColors.darkAmethyst,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Visualize semáforos, abrigos e condições da região.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.body.copyWith(
                              color: AppColors.darkAmethyst.withValues(
                                alpha: 0.82,
                              ),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
              child: _SearchBar(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: (value) => setState(() => _searchQuery = value),
                onLocationTap: () =>
                    _showMessage('A localização estará disponível em breve.'),
              ),
            ),
            if (_selectedMode == _MapMode.trafficLights &&
                _searchQuery.trim().isNotEmpty)
              _SearchResults(
                points: _trafficPoints,
                indexes: _matchingPointIndexes,
                onSelected: _selectTrafficPoint,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 12),
              child: _MapModeSelector(
                selectedMode: _selectedMode,
                onSelected: _selectMode,
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      const ClipRect(
                        child: CustomPaint(painter: _MapPainter()),
                      ),
                      if (_selectedMode == _MapMode.trafficLights)
                        for (
                          var index = 0;
                          index < _trafficPoints.length;
                          index++
                        )
                          Positioned(
                            left:
                                _trafficPoints[index].position.dx *
                                    constraints.maxWidth -
                                28,
                            top:
                                _trafficPoints[index].position.dy *
                                    constraints.maxHeight -
                                30,
                            child: _MapMarker(
                              point: _trafficPoints[index],
                              isSelected: index == _selectedTrafficIndex,
                              onTap: () => _openTrafficDetails(index),
                            ),
                          ),
                      if (_selectedMode == _MapMode.shelters)
                        for (
                          var index = 0;
                          index < _mappedShelters.length;
                          index++
                        )
                          Positioned(
                            left:
                                _mappedShelters[index].mapPosition!.dx *
                                    constraints.maxWidth -
                                28,
                            top:
                                _mappedShelters[index].mapPosition!.dy *
                                    constraints.maxHeight -
                                30,
                            child: _ShelterMarker(
                              shelter: _mappedShelters[index],
                              isSelected: index == _selectedShelterIndex,
                              onTap: () => _selectShelter(index),
                            ),
                          ),
                      if (_selectedMode == _MapMode.trafficLights)
                        Positioned(
                          left: 14,
                          right: 14,
                          bottom: 14,
                          child: _PointInfoCard(
                            point: _selectedPoint,
                            onDetails: () =>
                                _openTrafficDetails(_selectedTrafficIndex),
                          ),
                        ),
                      if (_selectedMode == _MapMode.shelters &&
                          _selectedShelterIndex != null)
                        Positioned(
                          left: 14,
                          right: 14,
                          bottom: 14,
                          child: _ShelterInfoCard(
                            shelter: _mappedShelters[_selectedShelterIndex!],
                            onDetails: () => Navigator.of(context).push(
                              PageRouteBuilder<void>(
                                pageBuilder: (_, __, ___) => ShelterDetailScreen(
                                  shelter:
                                      _mappedShelters[_selectedShelterIndex!],
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
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

class _SearchResults extends StatelessWidget {
  const _SearchResults({
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

class _MapModeSelector extends StatelessWidget {
  const _MapModeSelector({
    required this.selectedMode,
    required this.onSelected,
  });

  final _MapMode selectedMode;
  final ValueChanged<_MapMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 4,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.14),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: _MapModeChip(
                icon: Icons.traffic,
                label: 'Semáforos',
                isSelected: selectedMode == _MapMode.trafficLights,
                onTap: () => onSelected(_MapMode.trafficLights),
              ),
            ),
            Expanded(
              child: _MapModeChip(
                icon: Icons.home_work_outlined,
                label: 'Abrigos',
                isSelected: selectedMode == _MapMode.shelters,
                onTap: () => onSelected(_MapMode.shelters),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapModeChip extends StatelessWidget {
  const _MapModeChip({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : AppColors.darkAmethyst;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: isSelected ? AppColors.hotRose : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
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

class _ShelterMarker extends StatelessWidget {
  const _ShelterMarker({
    required this.shelter,
    required this.isSelected,
    required this.onTap,
  });

  final Shelter shelter;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: shelter.name,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          width: 56,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.hotRose,
                size: isSelected ? 54 : 50,
              ),
              Positioned(
                top: 9,
                child: Icon(
                  Icons.home_work_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShelterInfoCard extends StatelessWidget {
  const _ShelterInfoCard({required this.shelter, required this.onDetails});

  final Shelter shelter;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
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
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.hotRose.withValues(alpha: 0.13),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.home_work_outlined,
                    color: AppColors.hotRose,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    shelter.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.subtitle.copyWith(
                      color: AppColors.darkAmethyst,
                      fontSize: 16,
                    ),
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

class _MapPainter extends CustomPainter {
  const _MapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFF1EFF2);
    canvas.drawRect(Offset.zero & size, background);

    _drawGreenAreas(canvas, size);
    _drawBlocks(canvas, size);
    _drawRoads(canvas, size);
    _drawWaterway(canvas, size);
  }

  void _drawGreenAreas(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFD9ECCB);
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(size.width * 0.23, 0)
        ..lineTo(size.width * 0.14, size.height * 0.2)
        ..lineTo(0, size.height * 0.27)
        ..close(),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.76, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height * 0.25)
        ..lineTo(size.width * 0.82, size.height * 0.19)
        ..close(),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.74, size.height * 0.64)
        ..lineTo(size.width, size.height * 0.56)
        ..lineTo(size.width, size.height * 0.84)
        ..lineTo(size.width * 0.82, size.height * 0.92)
        ..close(),
      paint,
    );
  }

  void _drawBlocks(Canvas canvas, Size size) {
    final fill = Paint()..color = const Color(0xFFE8E4E8);
    final stroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final columns = 5;
    final rows = 7;
    final blockWidth = size.width / columns;
    final blockHeight = size.height / rows;

    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final left = column * blockWidth + 4;
        final top = row * blockHeight + 4;
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, blockWidth - 8, blockHeight - 8),
          const Radius.circular(3),
        );
        canvas.drawRRect(rect, fill);
        canvas.drawRRect(rect, stroke);
      }
    }
  }

  void _drawRoads(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;
    final detail = Paint()
      ..color = const Color(0xFFD8D3DA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final roads = [
      [Offset(0, size.height * 0.28), Offset(size.width, size.height * 0.73)],
      [Offset(size.width * 0.15, 0), Offset(size.width * 0.8, size.height)],
      [Offset(0, size.height * 0.78), Offset(size.width, size.height * 0.18)],
      [Offset(size.width * 0.72, 0), Offset(size.width * 0.25, size.height)],
    ];

    for (final road in roads) {
      canvas.drawLine(road[0], road[1], paint);
      canvas.drawLine(road[0], road[1], detail);
    }
  }

  void _drawWaterway(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9FD2EA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final path = Path()
      ..moveTo(size.width * 0.08, size.height)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.76,
        size.width * 0.13,
        size.height * 0.47,
        size.width * 0.38,
        size.height * 0.26,
      )
      ..cubicTo(
        size.width * 0.55,
        size.height * 0.12,
        size.width * 0.7,
        size.height * 0.3,
        size.width,
        size.height * 0.05,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) => false;
}
