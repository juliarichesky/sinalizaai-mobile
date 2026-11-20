import 'package:flutter/material.dart';

class Shelter {
  const Shelter({
    required this.id,
    required this.name,
    required this.distanceMeters,
    required this.isCovered,
    required this.isAccessible,
    required this.features,
    this.address,
    this.capacity,
    this.openingHours,
    this.contact,
    this.observations,
    this.imageAsset,
    this.mapPosition,
  });

  final String id;
  final String name;
  final int distanceMeters;
  final bool isCovered;
  final bool? isAccessible;
  final List<String> features;
  final String? address;
  final String? capacity;
  final String? openingHours;
  final String? contact;
  final String? observations;
  final String? imageAsset;
  // Coordenada relativa fictícia, usada somente para demonstrar o mapa.
  final Offset? mapPosition;

  String get formattedDistance {
    if (distanceMeters >= 1000) {
      final kilometers = distanceMeters / 1000;
      return '${kilometers.toStringAsFixed(1).replaceAll('.', ',')} km';
    }
    return '$distanceMeters m';
  }
}

// Dados exclusivamente demonstrativos, sem disponibilidade em tempo real.
const mockShelters = [
  Shelter(
    id: 'av-paulista',
    name: 'Abrigo Av. Paulista',
    distanceMeters: 350,
    isCovered: true,
    isAccessible: true,
    features: const [
      'Cobertura',
      'Bancos',
      'Acessibilidade (rampa)',
      'Iluminação',
    ],
    observations: 'Informações fictícias para demonstração.',
    mapPosition: Offset(0.31, 0.29),
  ),
  Shelter(
    id: 'consolacao',
    name: 'Abrigo Consolação',
    distanceMeters: 750,
    isCovered: true,
    isAccessible: true,
    features: const ['Cobertura', 'Bancos', 'Água potável'],
    observations: 'Dados demonstrativos; confirme as condições no local.',
    mapPosition: Offset(0.72, 0.47),
  ),
  Shelter(
    id: 'augusta',
    name: 'Abrigo Augusta',
    distanceMeters: 1200,
    isCovered: false,
    isAccessible: true,
    features: const ['Bancos', 'Área de descanso', 'Iluminação'],
    observations: 'Dados demonstrativos; cobertura não informada.',
    mapPosition: Offset(0.29, 0.73),
  ),
  Shelter(
    id: 'bela-vista',
    name: 'Abrigo Bela Vista',
    distanceMeters: 1600,
    isCovered: true,
    isAccessible: false,
    features: const ['Cobertura', 'Bancos', 'Iluminação'],
    address: 'Rua Treze de Maio, 210',
    observations: 'Dados demonstrativos; acessibilidade não informada.',
    mapPosition: Offset(0.56, 0.56),
  ),
  Shelter(
    id: 'paraiso',
    name: 'Abrigo Paraíso',
    distanceMeters: 2100,
    isCovered: false,
    isAccessible: null,
    features: const ['Bancos', 'Área de descanso'],
    address: 'Rua Vergueiro, 640',
    observations: 'Informações fictícias para demonstração.',
    mapPosition: Offset(0.13, 0.84),
  ),
];
