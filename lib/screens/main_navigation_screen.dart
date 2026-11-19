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
  late final List<Widget> _screens = [
    HomeScreen(showBottomNavigation: false, onNavigationRequested: _selectTab),
    MapScreen(showBottomNavigation: false, onNavigationRequested: _selectTab),
    SheltersScreen(
      showBottomNavigation: false,
      onNavigationRequested: _selectTab,
    ),
    AlertsScreen(
      showBottomNavigation: false,
      onNavigationRequested: _selectTab,
    ),
    ProfileScreen(
      showBottomNavigation: false,
      onNavigationRequested: _selectTab,
    ),
  ];

  void _selectTab(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
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
