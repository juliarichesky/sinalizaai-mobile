part of '../shelter_detail_screen.dart';

class _StructureSection extends StatelessWidget {
  const _StructureSection({required this.features});

  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Estrutura',
      child: features.isEmpty
          ? Text(
              'Nenhuma estrutura informada.',
              style: AppTypography.caption.copyWith(fontSize: 14),
            )
          : Column(
              children: features
                  .map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF4E9A5F),
                            size: 16,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              feature,
                              style: AppTypography.caption.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _InformationSection extends StatelessWidget {
  const _InformationSection({required this.shelter});

  final Shelter shelter;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Informações do abrigo',
      child: Column(
        children: [
          _InformationRow(
            icon: Icons.location_on_outlined,
            label: 'Endereço',
            value: shelter.address ?? 'Não informado',
          ),
          _InformationRow(
            icon: Icons.groups_outlined,
            label: 'Capacidade',
            value: shelter.capacity ?? 'Não informado',
          ),
          _InformationRow(
            icon: Icons.schedule_outlined,
            label: 'Horário de funcionamento',
            value: shelter.openingHours ?? 'Não informado',
          ),
          _InformationRow(
            icon: Icons.phone_outlined,
            label: 'Contato',
            value: shelter.contact ?? 'Não informado',
          ),
          _InformationRow(
            icon: Icons.notes_outlined,
            label: 'Observações',
            value: shelter.observations ?? 'Não informado',
          ),
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  const _InformationRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkAmethyst, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$label\n',
                style: AppTypography.caption.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: AppTypography.caption.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.subtitle.copyWith(fontSize: 20)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
