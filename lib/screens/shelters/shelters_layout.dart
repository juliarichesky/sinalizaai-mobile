part of '../shelters_screen.dart';

extension on _SheltersScreenState {
  Widget _buildContent(BuildContext context) {
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
                                icon: Icons.near_me_outlined,
                                isSelected:
                                    _selectedFilter == _ShelterFilter.nearby,
                                onTap: () =>
                                    _selectFilter(_ShelterFilter.nearby),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: _ShelterFilterChip(
                                label: 'Favoritos',
                                icon: Icons.favorite_border,
                                isSelected:
                                    _selectedFilter == _ShelterFilter.favorites,
                                onTap: () =>
                                    _selectFilter(_ShelterFilter.favorites),
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
                                  _updateFavorite(shelter, isFavorite);
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
