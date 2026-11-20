import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_alerts.dart';
import '../widgets/app_bottom_navigation.dart';
import 'home_screen.dart';
import 'alert_detail_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'shelters_screen.dart';

part 'alerts/alerts_content.dart';
part 'alerts/alert_cards.dart';
part 'alerts/alerts_layout.dart';

enum _AlertFilter { all, floods, traffic }

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({
    super.key,
    this.showBottomNavigation = true,
    this.onNavigationRequested,
    this.onBackRequested,
  });

  final bool showBottomNavigation;
  final ValueChanged<int>? onNavigationRequested;
  final VoidCallback? onBackRequested;

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  _AlertFilter _selectedFilter = _AlertFilter.all;

  void _selectFilter(_AlertFilter filter) {
    setState(() => _selectedFilter = filter);
  }

  List<MockAlert> get _visibleAlerts {
    switch (_selectedFilter) {
      case _AlertFilter.all:
        return mockAlerts;
      case _AlertFilter.floods:
        return mockAlerts
            .where((alert) => alert.category == AlertCategory.flood)
            .toList();
      case _AlertFilter.traffic:
        return mockAlerts
            .where((alert) => alert.category == AlertCategory.traffic)
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const SheltersScreen()),
        );
      case 3:
        break;
      case 4:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
        );
    }
  }

  Color _alertColor(MockAlert alert) {
    switch (alert.category) {
      case AlertCategory.flood:
        return Colors.blue;
      case AlertCategory.traffic:
        return AppColors.hotRose;
      case AlertCategory.maintenance:
        return AppColors.sunflowerGold;
    }
  }

  @override
  Widget build(BuildContext context) => _buildContent(context);
}
