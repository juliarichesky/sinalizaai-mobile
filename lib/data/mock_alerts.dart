import 'package:flutter/material.dart';

enum AlertCategory { flood, traffic, maintenance }

class MockAlert {
  const MockAlert({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.time,
    required this.icon,
  });

  final String title;
  final String description;
  final String? location;
  final AlertCategory category;
  final String time;
  final IconData icon;
}

const mockAlerts = [
  MockAlert(
    title: 'Risco de enchente',
    description: 'Nível moderado',
    location: 'Região: Centro',
    category: AlertCategory.flood,
    time: 'Há 10 min',
    icon: Icons.water,
  ),
  MockAlert(
    title: 'Trânsito intenso',
    description: 'Congestionamento na Av. Marginal',
    location: null,
    category: AlertCategory.traffic,
    time: 'Há 25 min',
    icon: Icons.traffic,
  ),
  MockAlert(
    title: 'Manutenção',
    description: 'Semáforo em manutenção na Rua Augusta',
    location: null,
    category: AlertCategory.maintenance,
    time: 'Há 1 h',
    icon: Icons.warning_amber_rounded,
  ),
  MockAlert(
    title: 'Chuva forte',
    description: 'Atenção para pontos de acúmulo de água',
    location: 'Região: Bela Vista',
    category: AlertCategory.flood,
    time: 'Há 40 min',
    icon: Icons.cloudy_snowing,
  ),
  MockAlert(
    title: 'Desvio de trânsito',
    description: 'Faixa interditada para manutenção viária',
    location: 'Av. Brigadeiro Luís Antônio',
    category: AlertCategory.traffic,
    time: 'Há 50 min',
    icon: Icons.alt_route,
  ),
  MockAlert(
    title: 'Obra programada',
    description: 'Intervenção temporária na calçada',
    location: 'Rua Haddock Lobo',
    category: AlertCategory.maintenance,
    time: 'Há 2 h',
    icon: Icons.construction_outlined,
  ),
];
