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
import 'map/map_search.dart';
import 'map/map_header.dart';

part 'map/map_painter.dart';
part 'map/map_content.dart';
part 'map/map_markers.dart';
part 'map/map_point_markers.dart';
part 'map/map_layout.dart';

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

  void _updateSearchQuery(String value) {
    setState(() => _searchQuery = value);
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
  Widget build(BuildContext context) => _buildContent(context);
}
