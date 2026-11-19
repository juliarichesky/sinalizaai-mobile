import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../widgets/app_bottom_navigation.dart';
import 'alerts_screen.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'shelters_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  int? _previousIndex;
  late final List<Widget> _screens = [
    HomeScreen(showBottomNavigation: false, onNavigationRequested: _selectTab),
    MapScreen(
      showBottomNavigation: false,
      onNavigationRequested: _selectTab,
      onBackRequested: _goToPreviousTab,
    ),
    SheltersScreen(
      showBottomNavigation: false,
      onNavigationRequested: _selectTab,
      onBackRequested: _goToPreviousTab,
    ),
    AlertsScreen(
      showBottomNavigation: false,
      onNavigationRequested: _selectTab,
      onBackRequested: _goToPreviousTab,
    ),
    ProfileScreen(
      showBottomNavigation: false,
      onNavigationRequested: _selectTab,
      onBackRequested: _goToPreviousTab,
    ),
  ];

  void _selectTab(int index) {
    if (index == _selectedIndex) {
      return;
    }
    _previousIndex = _selectedIndex;
    setState(() => _selectedIndex = index);
  }

  void _goToPreviousTab() {
    final previousIndex = _previousIndex;
    _previousIndex = null;
    if (previousIndex == null || previousIndex == _selectedIndex) {
      _selectTab(0);
      return;
    }
    setState(() => _selectedIndex = previousIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemSelected: _selectTab,
      ),
    );
  }
}
