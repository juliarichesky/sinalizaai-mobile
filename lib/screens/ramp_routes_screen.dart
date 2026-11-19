import 'package:flutter/material.dart';

import 'accessibility_resource_widgets.dart';

class RampRoutesScreen extends StatelessWidget {
  const RampRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccessibilityResourceScaffold(
      title: 'Rotas com rampas',
      subtitle: 'Conheça recursos que facilitam trajetos com desníveis.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AccessibilityIntroCard(
            icon: Icons.accessible_forward,
            title: 'Caminhos mais acessíveis',
            description: 'Rampas e rebaixamentos de guia podem facilitar o deslocamento de pessoas com mobilidade reduzida.',
          ),
          const SizedBox(height: 22),
          const AccessibilitySectionTitle(title: 'O que observar em uma rampa'),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.straighten,
            title: 'Inclinação',
            description: 'Uma inclinação adequada ajuda a tornar a subida e a descida mais confortáveis.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.grain,
            title: 'Superfície',
            description: 'O piso deve oferecer aderência e não apresentar irregularidades perigosas.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.open_in_full,
            title: 'Espaço de circulação',
            description:
                'É importante haver espaço livre para aproximação e passagem.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.alt_route,
            title: 'Continuidade do trajeto',
            description: 'A rampa deve conectar trechos acessíveis, sem obstáculos logo após sua saída.',
          ),
          const SizedBox(height: 22),
          const AccessibilitySectionTitle(title: 'Locais cadastrados'),
          const SizedBox(height: 10),
          const AccessibilityEmptyState(
            icon: Icons.location_off_outlined,
            message:
                'Ainda não há locais com rampas cadastrados para consulta.',
          ),
          const SizedBox(height: 14),
          const AccessibilityInfoCard(
            icon: Icons.lightbulb_outline,
            title: 'Orientações',
            description: 'Ao avaliar um trajeto, observe obstáculos, desníveis e a continuidade do caminho. Nenhuma rota deve ser considerada segura sem verificação.',
          ),
        ],
      ),
    );
  }
}
