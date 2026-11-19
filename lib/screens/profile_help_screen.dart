import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'profile_subpage_widgets.dart';

class ProfileHelpScreen extends StatelessWidget {
  const ProfileHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const questions = <(String, String)>[
      (
        'Como visualizar os semáforos no mapa?',
        'Abra o Mapa pela Home ou pela barra inferior e selecione Semáforos.',
      ),
      (
        'Como encontrar abrigos?',
        'Acesse Abrigos pela Home ou pela barra inferior para consultar a lista demonstrativa.',
      ),
      (
        'Como acompanhar os alertas?',
        'Abra Alertas para consultar os avisos disponíveis no aplicativo.',
      ),
      (
        'Como acessar os recursos de acessibilidade?',
        'Use o card Acessibilidade na Home ou as opções disponíveis nesta seção.',
      ),
      (
        'Como atualizar meus dados?',
        'Acesse Meus dados, ajuste as informações e salve. Nesta demonstração, a alteração é local.',
      ),
    ];

    return ProfileSubpageScaffold(
      title: 'Ajuda e suporte',
      subtitle: 'Encontre respostas e saiba como obter ajuda.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Perguntas frequentes',
            style: AppTypography.subtitle.copyWith(
              color: AppColors.darkAmethyst,
            ),
          ),
          const SizedBox(height: 10),
          ...questions.map(
            (question) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _QuestionCard(question: question.$1, answer: question.$2),
            ),
          ),
          const SizedBox(height: 12),
          ProfileWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Precisa de ajuda?',
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'No momento, não há um canal de atendimento externo configurado. Consulte as perguntas frequentes para orientações sobre o aplicativo.',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(20),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          iconColor: AppColors.hotRose,
          collapsedIconColor: AppColors.darkAmethyst,
          title: Text(
            question,
            style: AppTypography.body.copyWith(fontWeight: FontWeight.w700),
          ),
          children: [Text(answer, style: AppTypography.caption)],
        ),
      ),
    );
  }
}
