import 'package:flutter/material.dart';

import 'accessibility_resource_widgets.dart';

class AccessibleSidewalksScreen extends StatelessWidget {
  const AccessibleSidewalksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccessibilityResourceScaffold(
      title: 'Calçadas acessíveis',
      subtitle: 'Conheça características de trajetos mais inclusivos.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AccessibilityIntroCard(
            icon: Icons.accessible_forward,
            title: 'Mais conforto ao caminhar',
            description: 'Calçadas acessíveis favorecem o deslocamento de pessoas com diferentes necessidades de mobilidade.',
          ),
          const SizedBox(height: 22),
          const AccessibilitySectionTitle(title: 'Características importantes'),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.straighten,
            title: 'Faixa livre',
            description: 'Uma área de circulação desobstruída facilita a passagem de pedestres.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.linear_scale,
            title: 'Piso tátil',
            description: 'Quando corretamente instalado, auxilia na orientação de pessoas com deficiência visual.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.check_circle_outline,
            title: 'Superfície regular',
            description: 'Uma superfície estável e bem conservada ajuda a reduzir dificuldades de deslocamento.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.warning_amber_outlined,
            title: 'Ausência de obstáculos',
            description: 'Objetos, buracos e desníveis podem dificultar ou impedir a circulação.',
          ),
          const SizedBox(height: 22),
          const AccessibilitySectionTitle(title: 'Trechos cadastrados'),
          const SizedBox(height: 10),
          const AccessibilityEmptyState(
            icon: Icons.location_off_outlined,
            message:
                'Ainda não há trechos de calçadas cadastrados para consulta.',
          ),
          const SizedBox(height: 14),
          const AccessibilityInfoCard(
            icon: Icons.lightbulb_outline,
            title: 'Orientações',
            description: 'Observe as condições do piso, os obstáculos e a continuidade da circulação. Não classifique um trecho como acessível sem dados suficientes.',
          ),
        ],
      ),
    );
  }
}
