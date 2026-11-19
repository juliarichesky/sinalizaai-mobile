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
  Widget build(BuildContext context) {
    final shelters = _visibleShelters;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: widget.showBottomNavigation
          ? AppBottomNavigation(
              selectedIndex: 2,
              onItemSelected: _handleNavigation,
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            _SheltersHeader(onBack: _goBack, showBackButton: true),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: Colors.white,
                  elevation: 3,
                  shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _ShelterFilterChip(
                                label: 'Próximos',
                                isSelected:
                                    _selectedFilter == _ShelterFilter.nearby,
                                onTap: () => setState(
                                  () => _selectedFilter = _ShelterFilter.nearby,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: _ShelterFilterChip(
                                label: 'Favoritos',
                                isSelected:
                                    _selectedFilter == _ShelterFilter.favorites,
                                onTap: () => setState(
                                  () => _selectedFilter =
                                      _ShelterFilter.favorites,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: shelters.isEmpty
                  ? const _EmptyShelters()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                      itemCount: shelters.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 9),
                      itemBuilder: (context, index) {
                        final shelter = shelters[index];
                        return _ShelterCard(
                          shelter: shelter,
                          isFavorite: _favoriteIds.contains(shelter.id),
                          onFavorite: () => _toggleFavorite(shelter),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => ShelterDetailScreen(
                                shelter: shelter,
                                isFavorite: _favoriteIds.contains(shelter.id),
                                onFavoriteChanged: (isFavorite) {
                                  if (!mounted) {
                                    return;
                                  }
                                  setState(() {
                                    if (isFavorite) {
                                      _favoriteIds.add(shelter.id);
                                    } else {
                                      _favoriteIds.remove(shelter.id);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
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

class _SheltersHeader extends StatelessWidget {
  const _SheltersHeader({required this.onBack, required this.showBackButton});

  final VoidCallback onBack;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              onPressed: onBack,
              tooltip: 'Voltar',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              icon: const Icon(Icons.arrow_back_ios_new, size: 22),
              color: AppColors.darkAmethyst,
            ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abrigos',
                  style: AppTypography.heading.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Encontre locais de apoio e proteção na sua região.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontSize: 14,
                    color: AppColors.darkAmethyst.withValues(alpha: 0.82),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShelterFilterChip extends StatelessWidget {
  const _ShelterFilterChip({
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
        color: isSelected ? AppColors.hotRose : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            constraints: const BoxConstraints(minHeight: 46),
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(
                color: isSelected ? Colors.white : AppColors.darkAmethyst,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShelterCard extends StatelessWidget {
  const _ShelterCard({
    required this.shelter,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
  });

  final Shelter shelter;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label:
          '${shelter.name}, ${shelter.formattedDistance}, '
          '${shelter.isCovered ? 'Coberto' : 'Sem cobertura'}, '
          '${shelter.isAccessible == true ? 'Acessível' : 'Não acessível'}',
      child: Material(
        color: Colors.white,
        elevation: 1,
        shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
            child: Row(
              children: [
                SizedBox(
                  height: 52,
                  width: 52,
                  child: const Icon(
                    Icons.home_work_outlined,
                    color: AppColors.hotRose,
                    size: 27,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shelter.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.subtitle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${shelter.formattedDistance} • '
                        '${shelter.isCovered ? 'Coberto' : 'Sem cobertura'}',
                        style: AppTypography.caption.copyWith(fontSize: 13),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.accessibility_new,
                            color: AppColors.darkAmethyst,
                            size: 20,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            shelter.isAccessible == true
                                ? 'Acessível'
                                : 'Não acessível',
                            style: AppTypography.caption.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onFavorite,
                  tooltip: isFavorite
                      ? 'Remover dos favoritos'
                      : 'Adicionar aos favoritos',
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? AppColors.hotRose
                        : AppColors.darkAmethyst.withValues(alpha: 0.55),
                    size: 24,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.darkAmethyst,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyShelters extends StatelessWidget {
  const _EmptyShelters();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Você ainda não marcou nenhum abrigo como favorito.',
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(fontSize: 13),
        ),
      ),
    );
  }
}
