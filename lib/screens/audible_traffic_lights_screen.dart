import 'package:flutter/material.dart';

import 'accessibility_resource_widgets.dart';

class AudibleTrafficLightsScreen extends StatelessWidget {
  const AudibleTrafficLightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccessibilityResourceScaffold(
      title: 'Semáforos sonoros',
      subtitle: 'Entenda os recursos sonoros de travessia.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AccessibilityIntroCard(
            icon: Icons.volume_up_outlined,
            title: 'Travessias com sinalização sonora',
            description: 'Alguns semáforos oferecem sinais sonoros para auxiliar pessoas com deficiência visual.',
          ),
          const SizedBox(height: 22),
          const AccessibilitySectionTitle(title: 'Como funciona'),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.volume_up_outlined,
            title: 'Sinalização sonora',
            description: 'Em equipamentos compatíveis, sinais sonoros ajudam a identificar informações sobre a travessia.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.touch_app_outlined,
            title: 'Acionamento',
            description: 'Alguns dispositivos possuem botões ou mecanismos específicos para solicitar a sinalização.',
          ),
          const SizedBox(height: 10),
          const AccessibilityInfoCard(
            icon: Icons.directions_walk,
            title: 'Orientação na travessia',
            description: 'A sinalização sonora é um recurso de apoio e deve ser utilizada junto às demais condições da via.',
          ),
          const SizedBox(height: 22),
          const AccessibilitySectionTitle(title: 'Travessias cadastradas'),
          const SizedBox(height: 10),
          const AccessibilityEmptyState(
            icon: Icons.traffic_outlined,
            message:
                'Ainda não há semáforos sonoros cadastrados para consulta.',
          ),
          const SizedBox(height: 14),
          const AccessibilityInfoCard(
            icon: Icons.info_outline,
            title: 'Orientações',
            description: 'Observe as condições da travessia e utilize os recursos de orientação disponíveis. Nenhum som oficial é emitido por esta demonstração.',
          ),
        ],
      ),
    );
  }
}
