import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 47),
        SizedBox(
          height: 48,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Text(
                  'Criar conta',
                  textAlign: TextAlign.center,
                  style: AppTypography.heading.copyWith(fontSize: 22),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  tooltip: 'Voltar',
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.darkAmethyst,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Preencha seus dados para começar a usar o Sinaliza.Ai.',
          textAlign: TextAlign.center,
          style: AppTypography.caption.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}

class RegisterTermsAcceptance extends StatelessWidget {
  const RegisterTermsAcceptance({
    super.key,
    required this.accepted,
    required this.showError,
    required this.termsRecognizer,
    required this.privacyRecognizer,
    required this.onChanged,
  });

  final bool accepted;
  final bool showError;
  final TapGestureRecognizer termsRecognizer;
  final TapGestureRecognizer privacyRecognizer;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: accepted,
              activeColor: AppColors.hotRose,
              onChanged: (value) => onChanged(value ?? false),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text.rich(
                  TextSpan(
                    text: 'Aceito os ',
                    style: AppTypography.caption,
                    children: [
                      TextSpan(
                        text: 'Termos de Uso',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.hotRose,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: termsRecognizer,
                      ),
                      const TextSpan(text: ' e a '),
                      TextSpan(
                        text: 'Política de Privacidade',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.hotRose,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: privacyRecognizer,
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 2),
            child: Text(
              'Você precisa aceitar os Termos de Uso e a '
              'Política de Privacidade para continuar.',
              style: AppTypography.caption.copyWith(
                color: AppColors.nightBordeaux,
              ),
            ),
          ),
      ],
    );
  }
}
