import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_alerts.dart';
import '../widgets/app_bottom_navigation.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'shelters_screen.dart';

enum _AlertFilter { all, floods, traffic }

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({
    super.key,
    this.showBottomNavigation = true,
    this.onNavigationRequested,
  });

  final bool showBottomNavigation;
  final ValueChanged<int>? onNavigationRequested;

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  _AlertFilter _selectedFilter = _AlertFilter.all;

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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      bottomNavigationBar: widget.showBottomNavigation
          ? AppBottomNavigation(
              selectedIndex: 3,
              onItemSelected: _handleNavigation,
            )
          : null,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.softBackground,
              Colors.white.withValues(alpha: 0.72),
              AppColors.softBackground.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _AlertsHeader(
                onBack: () => Navigator.of(context).pop(),
                showBackButton: widget.showBottomNavigation,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'Todos',
                        isSelected: _selectedFilter == _AlertFilter.all,
                        onTap: () =>
                            setState(() => _selectedFilter = _AlertFilter.all),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Enchentes',
                        isSelected: _selectedFilter == _AlertFilter.floods,
                        onTap: () => setState(
                          () => _selectedFilter = _AlertFilter.floods,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Trânsito',
                        isSelected: _selectedFilter == _AlertFilter.traffic,
                        onTap: () => setState(
                          () => _selectedFilter = _AlertFilter.traffic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _visibleAlerts.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            'Nenhum alerta nesta categoria.',
                            textAlign: TextAlign.center,
                            style: AppTypography.body,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                        itemCount: _visibleAlerts.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final alert = _visibleAlerts[index];
                          return _AlertCard(
                            alert: alert,
                            color: _alertColor(alert),
                            onTap: () => _showMessage(
                              'Os detalhes deste alerta estarão disponíveis em breve.',
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertsHeader extends StatelessWidget {
  const _AlertsHeader({required this.onBack, required this.showBackButton});

  final VoidCallback onBack;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: onBack,
                tooltip: 'Voltar',
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.darkAmethyst,
                ),
              ),
            ),
          Text(
            'Alertas',
            style: AppTypography.subtitle.copyWith(
              color: AppColors.darkAmethyst,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: isSelected
            ? AppColors.darkAmethyst
            : Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            constraints: const BoxConstraints(minHeight: 36),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.darkAmethyst
                    : AppColors.darkAmethyst.withValues(alpha: 0.12),
              ),
            ),
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                color: isSelected ? Colors.white : AppColors.darkAmethyst,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.alert,
    required this.color,
    required this.onTap,
  });

  final MockAlert alert;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${alert.title}. ${alert.description}. ${alert.time}',
      child: Material(
        color: Colors.white.withValues(alpha: 0.7),
        elevation: 1,
        shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(alert.icon, color: color, size: 23),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.title,
                        style: AppTypography.subtitle.copyWith(
                          color: AppColors.darkAmethyst,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        alert.description,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.nightBordeaux,
                          fontSize: 11,
                        ),
                      ),
                      if (alert.location != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          alert.location!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.nightBordeaux,
                            fontSize: 11,
                          ),
                        ),
                      ],
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          alert.time,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.nightBordeaux,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
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
