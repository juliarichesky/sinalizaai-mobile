part of '../map_screen.dart';

class _ShelterMarker extends StatelessWidget {
  const _ShelterMarker({
    required this.shelter,
    required this.isSelected,
    required this.onTap,
  });

  final Shelter shelter;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: shelter.name,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          width: 56,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.hotRose,
                size: isSelected ? 54 : 50,
              ),
              Positioned(
                top: 9,
                child: Icon(
                  Icons.home_work_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShelterInfoCard extends StatelessWidget {
  const _ShelterInfoCard({required this.shelter, required this.onDetails});

  final Shelter shelter;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 10, 14),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 54,
              decoration: BoxDecoration(
                color: AppColors.darkAmethyst.withValues(alpha: 0.28),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.hotRose.withValues(alpha: 0.13),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.home_work_outlined,
                    color: AppColors.hotRose,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    shelter.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.subtitle.copyWith(
                      color: AppColors.darkAmethyst,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _DetailsButton(onPressed: onDetails),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

