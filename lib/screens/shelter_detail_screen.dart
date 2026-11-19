import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_shelters.dart';

class ShelterDetailScreen extends StatefulWidget {
  const ShelterDetailScreen({
    super.key,
    required this.shelter,
    this.isFavorite = false,
    this.onFavoriteChanged,
  });

  final Shelter shelter;
  final bool isFavorite;
  final ValueChanged<bool>? onFavoriteChanged;

  @override
  State<ShelterDetailScreen> createState() => _ShelterDetailScreenState();
}

class _ShelterDetailScreenState extends State<ShelterDetailScreen> {
  late bool _isFavorite = widget.isFavorite;

  @override
  void didUpdateWidget(covariant ShelterDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onFavoriteChanged?.call(_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final shelter = widget.shelter;

    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/all_img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _DetailHeader(onBack: () => Navigator.of(context).pop()),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ShelterImage(shelter: shelter),
                      const SizedBox(height: 14),
                      _IdentitySection(
                        shelter: shelter,
                        isFavorite: _isFavorite,
                        onFavorite: _toggleFavorite,
                      ),
                      const SizedBox(height: 14),
                      _Characteristics(shelter: shelter),
                      const SizedBox(height: 18),
                      _StructureSection(features: shelter.features),
                      const SizedBox(height: 18),
                      _InformationSection(shelter: shelter),
                      const SizedBox(height: 12),
                      Text(
                        'Dados demonstrativos. As informações não representam '
                        'disponibilidade ou condições verificadas em tempo real.',
                        textAlign: TextAlign.center,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.nightBordeaux.withValues(
                            alpha: 0.75,
                          ),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
