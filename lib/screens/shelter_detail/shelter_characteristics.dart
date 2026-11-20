part of '../shelter_detail_screen.dart';

class _Characteristics extends StatelessWidget {
  const _Characteristics({required this.shelter});

  final Shelter shelter;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Characteristic(
          icon: shelter.isCovered ? Icons.roofing : Icons.wb_sunny_outlined,
          label: shelter.isCovered ? 'Coberto' : 'Sem cobertura',
          color: shelter.isCovered
              ? const Color(0xFF3D8B5A)
              : AppColors.nightBordeaux,
        ),
        _Characteristic(
          icon: Icons.accessibility_new,
          label: shelter.isAccessible == true
              ? 'Acessível'
              : 'Acessibilidade não informada',
          color: const Color(0xFF7351A7),
        ),
      ],
    );
  }
}

class _Characteristic extends StatelessWidget {
  const _Characteristic({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

