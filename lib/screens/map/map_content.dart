part of '../map_screen.dart';

class _MapModeSelector extends StatelessWidget {
  const _MapModeSelector({
    required this.selectedMode,
    required this.onSelected,
  });

  final _MapMode selectedMode;
  final ValueChanged<_MapMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 4,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.14),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: _MapModeChip(
                icon: Icons.traffic,
                label: 'Semáforos',
                isSelected: selectedMode == _MapMode.trafficLights,
                onTap: () => onSelected(_MapMode.trafficLights),
              ),
            ),
            Expanded(
              child: _MapModeChip(
                icon: Icons.home_work_outlined,
                label: 'Abrigos',
                isSelected: selectedMode == _MapMode.shelters,
                onTap: () => onSelected(_MapMode.shelters),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapModeChip extends StatelessWidget {
  const _MapModeChip({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : AppColors.darkAmethyst;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
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

