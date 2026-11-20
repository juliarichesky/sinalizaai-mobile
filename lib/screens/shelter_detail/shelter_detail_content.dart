part of '../shelter_detail_screen.dart';

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
      child: Row(
        children: [
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
                  'Detalhes do abrigo',
                  style: AppTypography.heading.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Informações sobre o local selecionado.',
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

class _ShelterImage extends StatelessWidget {
  const _ShelterImage({required this.shelter});

  final Shelter shelter;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: shelter.imageAsset == null
            ? DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.hotRose.withValues(alpha: 0.18),
                      AppColors.lavenderVeil,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.home_work_outlined,
                    color: AppColors.hotRose,
                    size: 56,
                  ),
                ),
              )
            : Image.asset(shelter.imageAsset!, fit: BoxFit.cover),
      ),
    );
  }
}

class _IdentitySection extends StatelessWidget {
  const _IdentitySection({
    required this.shelter,
    required this.isFavorite,
    required this.onFavorite,
  });

  final Shelter shelter;
  final bool isFavorite;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shelter.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.subtitle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.near_me_outlined,
                    color: AppColors.darkAmethyst,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      shelter.formattedDistance,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                shelter.address ?? 'Endereço não informado',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(fontSize: 14),
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
            color: AppColors.hotRose,
            size: 24,
          ),
        ),
      ],
    );
  }
}

