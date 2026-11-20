import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_shelters.dart';
import '../widgets/app_bottom_navigation.dart';
import 'alerts_screen.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'shelter_detail_screen.dart';

part 'shelters/shelters_content.dart';
part 'shelters/shelter_cards.dart';
part 'shelters/shelters_layout.dart';

enum _ShelterFilter { nearby, favorites }

class SheltersScreen extends StatefulWidget {
  const SheltersScreen({
    super.key,
    this.showBottomNavigation = true,
    this.onNavigationRequested,
    this.onBackRequested,
  });

  final bool showBottomNavigation;
  final ValueChanged<int>? onNavigationRequested;
  final VoidCallback? onBackRequested;

  @override
  State<SheltersScreen> createState() => _SheltersScreenState();
}

class _SheltersScreenState extends State<SheltersScreen> {
  _ShelterFilter _selectedFilter = _ShelterFilter.nearby;
  final Set<String> _favoriteIds = <String>{};

  List<Shelter> get _visibleShelters {
    final shelters = [...mockShelters]
      ..sort(
        (first, second) =>
            first.distanceMeters.compareTo(second.distanceMeters),
      );

    switch (_selectedFilter) {
      case _ShelterFilter.nearby:
        return shelters;
      case _ShelterFilter.favorites:
        return shelters
            .where((shelter) => _favoriteIds.contains(shelter.id))
            .toList();
    }
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

  void _toggleFavorite(Shelter shelter) {
    setState(() {
      if (!_favoriteIds.add(shelter.id)) {
        _favoriteIds.remove(shelter.id);
      }
    });
  }

  void _selectFilter(_ShelterFilter filter) {
    setState(() => _selectedFilter = filter);
  }

  void _updateFavorite(Shelter shelter, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        _favoriteIds.add(shelter.id);
      } else {
        _favoriteIds.remove(shelter.id);
      }
    });
  }

  void _handleNavigation(int index) {
    if (widget.onNavigationRequested != null) {
      widget.onNavigationRequested!(index);
      return;
    }
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
        );
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const MapScreen()),
        );
      case 2:
        break;
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const AlertsScreen()),
        );
      case 4:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
        );
    }
  }

  @override
  Widget build(BuildContext context) => _buildContent(context);
}
