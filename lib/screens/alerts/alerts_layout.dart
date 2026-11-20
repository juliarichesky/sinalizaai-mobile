part of '../alerts_screen.dart';

extension on _AlertsScreenState {
  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: widget.showBottomNavigation
          ? AppBottomNavigation(
              selectedIndex: 3,
              onItemSelected: _handleNavigation,
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            _AlertsHeader(onBack: _goBack, showBackButton: true),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: Colors.white,
                  elevation: 3,
                  shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: _FilterChip(
                            label: 'Todos',
                            icon: Icons.tune,
                            isSelected: _selectedFilter == _AlertFilter.all,
                            onTap: () => _selectFilter(_AlertFilter.all),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: _FilterChip(
                            label: 'Enchentes',
                            icon: Icons.water,
                            isSelected: _selectedFilter == _AlertFilter.floods,
                            onTap: () => _selectFilter(_AlertFilter.floods),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: _FilterChip(
                            label: 'Trânsito',
                            icon: Icons.traffic,
                            isSelected: _selectedFilter == _AlertFilter.traffic,
                            onTap: () => _selectFilter(_AlertFilter.traffic),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => AlertDetailScreen(alert: alert),
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
