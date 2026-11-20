part of '../shelters_screen.dart';

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
