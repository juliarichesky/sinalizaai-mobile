part of '../map_screen.dart';

extension on _MapScreenState {
  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: widget.showBottomNavigation
          ? AppBottomNavigation(selectedIndex: 1, onItemSelected: _navigate)
          : null,
      body: SafeArea(
        child: Column(
          children: [
            MapHeader(onBack: _goBack),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
              child: MapSearchBar(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: _updateSearchQuery,
                onLocationTap: () =>
                    _showMessage('A localização estará disponível em breve.'),
              ),
            ),
            if (_selectedMode == _MapMode.trafficLights &&
                _searchQuery.trim().isNotEmpty)
              MapSearchResults(
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
