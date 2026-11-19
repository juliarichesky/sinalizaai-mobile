import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_shelters.dart';
import 'home_screen.dart';
import 'map_screen.dart';

enum _ShelterFilter { nearby, favorites, rated }

class SheltersScreen extends StatefulWidget {
  const SheltersScreen({super.key});

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
      case _ShelterFilter.rated:
        return shelters.where((shelter) => shelter.hasRating).toList();
    }
  }

  void _goBack() {
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

  void _openMap() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MapScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shelters = _visibleShelters;

    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SafeArea(
        child: Column(
          children: [
            _SheltersHeader(onBack: _goBack),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
              child: Row(
                children: [
                  _ShelterFilterChip(
                    label: 'Próximos',
                    isSelected: _selectedFilter == _ShelterFilter.nearby,
                    onTap: () =>
                        setState(() => _selectedFilter = _ShelterFilter.nearby),
                  ),
                  const SizedBox(width: 8),
                  _ShelterFilterChip(
                    label: 'Favoritos',
                    isSelected: _selectedFilter == _ShelterFilter.favorites,
                    onTap: () => setState(
                      () => _selectedFilter = _ShelterFilter.favorites,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _ShelterFilterChip(
                    label: 'Avaliados',
                    isSelected: _selectedFilter == _ShelterFilter.rated,
                    onTap: () =>
                        setState(() => _selectedFilter = _ShelterFilter.rated),
                  ),
                ],
              ),
            ),
            Expanded(
              child: shelters.isEmpty
                  ? _EmptyShelters(filter: _selectedFilter)
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
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
              child: _MapButton(onTap: _openMap),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheltersHeader extends StatelessWidget {
  const _SheltersHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              tooltip: 'Voltar',
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: AppColors.darkAmethyst,
            ),
          ),
          Text('Abrigos', style: AppTypography.subtitle.copyWith(fontSize: 17)),
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
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            constraints: const BoxConstraints(minHeight: 34),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? AppColors.hotRose
                    : AppColors.darkAmethyst.withValues(alpha: 0.14),
              ),
            ),
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                color: isSelected ? Colors.white : AppColors.darkAmethyst,
                fontSize: 10,
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
  });

  final Shelter shelter;
  final bool isFavorite;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label:
          '${shelter.name}, ${shelter.formattedDistance}, '
          '${shelter.isCovered ? 'Coberto' : 'Sem cobertura'}, '
          '${shelter.isAccessible ? 'Acessível' : 'Não acessível'}',
      child: Material(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 9, 5, 9),
          child: Row(
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                  color: AppColors.hotRose.withValues(alpha: 0.13),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.home_work_outlined,
                  color: AppColors.hotRose,
                  size: 23,
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
                      style: AppTypography.subtitle.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${shelter.formattedDistance} • '
                      '${shelter.isCovered ? 'Coberto' : 'Sem cobertura'}',
                      style: AppTypography.caption.copyWith(fontSize: 10),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.accessibility_new,
                          color: AppColors.darkAmethyst,
                          size: 13,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          shelter.isAccessible ? 'Acessível' : 'Não acessível',
                          style: AppTypography.caption.copyWith(fontSize: 10),
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
                  size: 17,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.darkAmethyst,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyShelters extends StatelessWidget {
  const _EmptyShelters({required this.filter});

  final _ShelterFilter filter;

  @override
  Widget build(BuildContext context) {
    final message = filter == _ShelterFilter.favorites
        ? 'Você ainda não marcou nenhum abrigo como favorito.'
        : 'Ainda não há abrigos avaliados.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(fontSize: 13),
        ),
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.location_on_outlined, size: 17),
        label: const Text('Ver no mapa'),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.hotRose,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 11),
          textStyle: AppTypography.body.copyWith(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
