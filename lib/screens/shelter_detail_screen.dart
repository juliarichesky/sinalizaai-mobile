import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_shelters.dart';

part 'shelter_detail/shelter_detail_content.dart';
part 'shelter_detail/shelter_detail_information.dart';
part 'shelter_detail/shelter_characteristics.dart';

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

